# One-time merge script: merge enriched Google Places JSON into existing
# COURTS data in index.html. Outputs merged JS array literals to stdout.

$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$htmlPath = Join-Path $root 'index.html'
$tennisJsonPath = Join-Path $root 'bangkok_tennis_courts.json'
$pickleJsonPath = Join-Path $root 'bangkok_pickleball_courts.json'

# ---------- Load new JSON enrichment data ----------
# Note: must read with UTF8 encoding — these files have no BOM, and PS 5.1
# defaults to system ANSI codepage which mangles Thai characters.
$tennisNew = (Get-Content $tennisJsonPath -Raw -Encoding UTF8 | ConvertFrom-Json).courts
$pickleNew = (Get-Content $pickleJsonPath -Raw -Encoding UTF8 | ConvertFrom-Json).courts

# ---------- Extract existing arrays from index.html ----------
$html = Get-Content $htmlPath -Raw -Encoding UTF8

function Extract-Array($html, $varName) {
  # Match `const VARNAME = [...]` non-greedy across newlines
  $pattern = "(?s)const\s+$varName\s*=\s*\[(.*?)^\];"
  $m = [regex]::Match($html, $pattern, [Text.RegularExpressions.RegexOptions]::Multiline)
  if (-not $m.Success) { throw "Could not find $varName" }
  return $m.Groups[1].Value
}

function ConvertJsArrayToObjects($jsBody) {
  # Each court object is on a single line: { id:1, name:"...", ... },
  # Split on lines, filter to lines containing `id:`, parse each as JSON after key-quoting
  $courts = @()
  foreach ($line in $jsBody -split "`n") {
    $line = $line.Trim()
    if (-not $line.StartsWith('{')) { continue }
    if (-not ($line -match '\bid\s*:\s*\d+')) { continue }
    # Drop trailing comma
    if ($line.EndsWith(',')) { $line = $line.Substring(0, $line.Length - 1) }
    # Quote bare identifier keys: word followed by colon (not preceded by ":" -- avoid times/URLs)
    # Only target keys after { or , (with optional whitespace)
    $jsonLine = [regex]::Replace($line, '([\{,]\s*)([a-zA-Z_][a-zA-Z0-9_]*)\s*:', '$1"$2":')
    try {
      $obj = $jsonLine | ConvertFrom-Json
    } catch {
      Write-Host "Failed to parse line: $line" -ForegroundColor Red
      Write-Host "After convert: $jsonLine" -ForegroundColor Yellow
      throw
    }
    $courts += $obj
  }
  return ,$courts
}

$tennisExistingBody = Extract-Array $html 'TENNIS_COURTS'
$pickleExistingBody = Extract-Array $html 'PICKLEBALL_COURTS'
$tennisExisting = ConvertJsArrayToObjects $tennisExistingBody
$pickleExisting = ConvertJsArrayToObjects $pickleExistingBody

Write-Host "Loaded existing — Tennis: $($tennisExisting.Count), Pickleball: $($pickleExisting.Count)" -ForegroundColor Cyan
Write-Host "Loaded new JSON — Tennis: $($tennisNew.Count), Pickleball: $($pickleNew.Count)" -ForegroundColor Cyan

# ---------- Helpers ----------
function Normalize-Name($s) {
  if (-not $s) { return '' }
  $s = $s.ToLower()
  $s = $s -replace '[\s\p{P}\p{S}]+', ''
  return $s
}

$ZONE_MAP = @{
  'Central'             = 'ใจกลางกรุง'
  'Sukhumvit'           = 'สุขุมวิท'
  'East Bangkok'        = 'ฝั่งตะวันออก'
  'Outskirts (East)'    = 'ฝั่งตะวันออก'
  'North Bangkok'       = 'ฝั่งเหนือ'
  'Outskirts (North)'   = 'ฝั่งเหนือ'
  'South Bangkok'       = 'ฝั่งใต้'
  'West Bangkok'        = 'ฝั่งตะวันตก'
  'Thonburi'            = 'ริมแม่น้ำ'
}

function Map-Zone($z) {
  if ($ZONE_MAP.ContainsKey($z)) { return $ZONE_MAP[$z] }
  return $z
}

function Distance-Km($lat1, $lng1, $lat2, $lng2) {
  $r = 6371.0
  $toRad = [Math]::PI / 180.0
  $dLat = ($lat2 - $lat1) * $toRad
  $dLng = ($lng2 - $lng1) * $toRad
  $a = [Math]::Sin($dLat/2) * [Math]::Sin($dLat/2) +
       [Math]::Cos($lat1*$toRad) * [Math]::Cos($lat2*$toRad) *
       [Math]::Sin($dLng/2) * [Math]::Sin($dLng/2)
  $c = 2 * [Math]::Atan2([Math]::Sqrt($a), [Math]::Sqrt(1-$a))
  return $r * $c
}

# ---------- Merge logic ----------
function Merge-Set($existingArr, $newArr, $idStart) {
  $matched = @{}    # newIdx -> existingIdx
  $existingMatched = @{}

  # Pass 1: match by normalized name (existing.name|nameTh ↔ new.name|name_th)
  for ($i = 0; $i -lt $existingArr.Count; $i++) {
    $e = $existingArr[$i]
    $eNames = @(Normalize-Name $e.name; Normalize-Name $e.nameTh) | Where-Object { $_ }
    for ($j = 0; $j -lt $newArr.Count; $j++) {
      if ($matched.ContainsKey($j)) { continue }
      $n = $newArr[$j]
      $nNames = @(Normalize-Name $n.name; Normalize-Name $n.name_th) | Where-Object { $_ }
      $hit = $false
      foreach ($a in $eNames) { foreach ($b in $nNames) {
        if ($a -eq $b -and $a.Length -ge 4) { $hit = $true; break }
        # Substring match if reasonably long
        if ($a.Length -ge 6 -and $b.Length -ge 6 -and ($a.Contains($b) -or $b.Contains($a))) { $hit = $true; break }
      } if ($hit) { break } }
      if ($hit) {
        $matched[$j] = $i
        $existingMatched[$i] = $j
        break
      }
    }
  }

  # Pass 2: match by GPS proximity for unmatched
  # - <150m → strong match (assume same facility)
  # - 150–500m → require shared meaningful keyword (4+ chars, not generic)
  $stop = @('tennis','court','courts','club','sport','sports','academy','center','centre','complex','bangkok','the','and','of','sports')
  for ($i = 0; $i -lt $existingArr.Count; $i++) {
    if ($existingMatched.ContainsKey($i)) { continue }
    $e = $existingArr[$i]
    if (-not $e.lat -or -not $e.lng) { continue }
    $eTokens = @(($e.name + ' ' + $e.nameTh).ToLower() -split '[^a-zA-Z฀-๿]+' | Where-Object { $_.Length -ge 4 -and $stop -notcontains $_ })
    for ($j = 0; $j -lt $newArr.Count; $j++) {
      if ($matched.ContainsKey($j)) { continue }
      $n = $newArr[$j]
      if (-not $n.lat -or -not $n.lng) { continue }
      $d = Distance-Km $e.lat $e.lng $n.lat $n.lng
      if ($d -lt 0.15) {
        $matched[$j] = $i
        $existingMatched[$i] = $j
        Write-Host ("  GPS match (<150m): '{0}' <-> '{1}' ({2:F3}km)" -f $e.name, $n.name, $d) -ForegroundColor DarkGray
        break
      }
      if ($d -lt 0.5) {
        $nTokens = @(($n.name + ' ' + $n.name_th).ToLower() -split '[^a-zA-Z฀-๿]+' | Where-Object { $_.Length -ge 4 -and $stop -notcontains $_ })
        $shared = @($eTokens | Where-Object { $nTokens -contains $_ })
        if ($shared.Count -gt 0) {
          $matched[$j] = $i
          $existingMatched[$i] = $j
          Write-Host ("  GPS+token match: '{0}' <-> '{1}' ({2:F3}km, shared: {3})" -f $e.name, $n.name, $d, ($shared -join ',')) -ForegroundColor DarkGray
          break
        }
      }
    }
  }

  # Build merged array
  $result = @()
  $usedIds = @{}
  foreach ($e in $existingArr) { $usedIds[[int]$e.id] = $true }

  # First: process all existing courts (preserves their order/ids)
  for ($i = 0; $i -lt $existingArr.Count; $i++) {
    $e = $existingArr[$i]
    if ($existingMatched.ContainsKey($i)) {
      $n = $newArr[$existingMatched[$i]]
      # Merge: JSON wins on overlapping fields
      $merged = [ordered]@{
        id           = $e.id
        name         = if ($n.name) { $n.name } else { $e.name }
        nameTh       = if ($n.name_th) { $n.name_th } else { $e.nameTh }
        district     = if ($n.district) { $n.district } else { $e.district }
        districtEn   = $e.districtEn
        zone         = Map-Zone $n.zone
        address      = if ($n.address) { $n.address } else { $e.address }
        type         = $e.type
        indoor       = if ($null -ne $n.indoor) { [bool]$n.indoor } else { [bool]$e.indoor }
        nightLights  = [bool]$e.nightLights
        aircon       = [bool]$e.aircon
        courts       = $e.courts
        priceMin     = $e.priceMin
        priceMax     = $e.priceMax
        rating       = if ($null -ne $n.rating) { $n.rating } else { $e.rating }
        reviews      = if ($null -ne $n.rating_count) { [int]$n.rating_count } else { $e.reviews }
        bts          = $e.bts
        facilities   = $e.facilities
        hours        = $e.hours
        phone        = if ($n.phone) { $n.phone } else { $e.phone }
        featured     = [bool]$e.featured
        lat          = if ($null -ne $n.lat) { $n.lat } else { $e.lat }
        lng          = if ($null -ne $n.lng) { $n.lng } else { $e.lng }
        googleMaps   = $e.googleMaps
        website      = if ($n.website) { $n.website } else { $e.website }
        image        = $e.image
        place_id     = $n.place_id
        photos       = $n.photos
        notes        = $n.notes
      }
      $result += [pscustomobject]$merged
    } else {
      # Unmatched existing court — keep as is
      $merged = [ordered]@{
        id           = $e.id
        name         = $e.name
        nameTh       = $e.nameTh
        district     = $e.district
        districtEn   = $e.districtEn
        zone         = $e.zone
        address      = $e.address
        type         = $e.type
        indoor       = [bool]$e.indoor
        nightLights  = [bool]$e.nightLights
        aircon       = [bool]$e.aircon
        courts       = $e.courts
        priceMin     = $e.priceMin
        priceMax     = $e.priceMax
        rating       = $e.rating
        reviews      = $e.reviews
        bts          = $e.bts
        facilities   = $e.facilities
        hours        = $e.hours
        phone        = $e.phone
        featured     = [bool]$e.featured
        lat          = $e.lat
        lng          = $e.lng
        googleMaps   = $e.googleMaps
        website      = $e.website
        image        = $e.image
      }
      $result += [pscustomobject]$merged
    }
  }

  # Second: append unmatched new courts
  $nextId = $idStart
  while ($usedIds.ContainsKey($nextId)) { $nextId++ }
  for ($j = 0; $j -lt $newArr.Count; $j++) {
    if ($matched.ContainsKey($j)) { continue }
    $n = $newArr[$j]
    $merged = [ordered]@{
      id           = $nextId
      name         = $n.name
      nameTh       = if ($n.name_th) { $n.name_th } else { $n.name }
      district     = $n.district
      districtEn   = $n.district  # same; existing data has them as separate
      zone         = Map-Zone $n.zone
      address      = $n.address
      type         = 'hard'
      indoor       = [bool]$n.indoor
      nightLights  = $true
      aircon       = $false
      courts       = $null
      priceMin     = $null
      priceMax     = $null
      rating       = $n.rating
      reviews      = if ($null -ne $n.rating_count) { [int]$n.rating_count } else { $null }
      bts          = $null
      facilities   = @()
      hours        = $null
      phone        = $n.phone
      featured     = $false
      lat          = $n.lat
      lng          = $n.lng
      googleMaps   = $null
      website      = $n.website
      image        = $null
      place_id     = $n.place_id
      photos       = $n.photos
      notes        = $n.notes
    }
    $result += [pscustomobject]$merged
    $usedIds[$nextId] = $true
    $nextId++
    while ($usedIds.ContainsKey($nextId)) { $nextId++ }
  }

  Write-Host "  Matched: $($matched.Count) / $($newArr.Count) new entries" -ForegroundColor Green
  Write-Host "  Output total: $($result.Count) courts" -ForegroundColor Green
  return ,$result
}

Write-Host "`n=== Merging Tennis ===" -ForegroundColor Cyan
$tennisMerged = Merge-Set $tennisExisting $tennisNew 31
Write-Host "`n=== Merging Pickleball ===" -ForegroundColor Cyan
$pickleMerged = Merge-Set $pickleExisting $pickleNew 121

# ---------- Format as JS object literal (single line per court) ----------
function Format-Value($v) {
  if ($null -eq $v) { return 'null' }
  # Check string FIRST — strings have PSObject.Properties (Length) and would
  # otherwise be misclassified as objects by later checks.
  if ($v -is [string]) {
    $s = $v
    $s = $s -replace '\\', '\\\\'
    $s = $s -replace '"',  '\"'
    $s = $s -replace "`r", '\r'
    $s = $s -replace "`n", '\n'
    $s = $s -replace "`t", '\t'
    return '"' + $s + '"'
  }
  if ($v -is [bool]) { return $(if ($v) { 'true' } else { 'false' }) }
  if ($v -is [int] -or $v -is [long] -or $v -is [double] -or $v -is [decimal]) { return $v.ToString([System.Globalization.CultureInfo]::InvariantCulture) }
  if ($v -is [array] -or $v -is [System.Collections.IList]) {
    $items = @($v | ForEach-Object { Format-Value $_ })
    return '[' + ($items -join ',') + ']'
  }
  if ($v -is [pscustomobject] -or $v -is [hashtable]) {
    $props = if ($v -is [pscustomobject]) { $v.PSObject.Properties } else { $v.GetEnumerator() | ForEach-Object { [pscustomobject]@{Name=$_.Key; Value=$_.Value} } }
    $pairs = @()
    foreach ($p in $props) {
      $pairs += ('{0}:{1}' -f $p.Name, (Format-Value $p.Value))
    }
    return '{' + ($pairs -join ',') + '}'
  }
  # Fallback: treat as string
  return Format-Value ([string]$v)
}

function Format-CourtAsJsLiteral($c) {
  $pairs = @()
  foreach ($p in $c.PSObject.Properties) {
    if ($null -eq $p.Value) { continue }  # skip null fields to keep file lean
    $pairs += ('{0}:{1}' -f $p.Name, (Format-Value $p.Value))
  }
  return '  { ' + ($pairs -join ', ') + ' },'
}

$tennisLines = @($tennisMerged | ForEach-Object { Format-CourtAsJsLiteral $_ })
$pickleLines = @($pickleMerged | ForEach-Object { Format-CourtAsJsLiteral $_ })

# ---------- Replace arrays in index.html ----------
$tennisBlock = "const TENNIS_COURTS = [`n" + ($tennisLines -join "`n") + "`n];"
$pickleBlock = "const PICKLEBALL_COURTS = [`n" + ($pickleLines -join "`n") + "`n];"

$html = [regex]::Replace($html, '(?ms)const\s+TENNIS_COURTS\s*=\s*\[.*?^\];', $tennisBlock.Replace('$', '$$$$'))
$html = [regex]::Replace($html, '(?ms)const\s+PICKLEBALL_COURTS\s*=\s*\[.*?^\];', $pickleBlock.Replace('$', '$$$$'))

[System.IO.File]::WriteAllText($htmlPath, $html, (New-Object System.Text.UTF8Encoding $false))
Write-Host "`nUpdated: $htmlPath" -ForegroundColor Green
Write-Host ("  Tennis array: {0} courts" -f $tennisMerged.Count) -ForegroundColor Green
Write-Host ("  Pickleball array: {0} courts" -f $pickleMerged.Count) -ForegroundColor Green

# ---------- Also write intermediate JSON for inspection ----------
$tennisOut = Join-Path $root 'merged_tennis.json'
$pickleOut = Join-Path $root 'merged_pickleball.json'
$tennisMerged | ConvertTo-Json -Depth 10 | Out-File $tennisOut -Encoding utf8
$pickleMerged | ConvertTo-Json -Depth 10 | Out-File $pickleOut -Encoding utf8
