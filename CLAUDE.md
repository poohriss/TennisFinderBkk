# TennisFinder BKK

เว็บรวบรวมสนามเทนนิสในกรุงเทพฯ — bilingual (ไทย/EN), single-file HTML app

## ไฟล์

- `index.html` — ไฟล์เดียวทั้งหมด (React + Babel in-browser, Leaflet map)
- ไม่มี build process, ไม่มี dependency ต้องติดตั้ง — เปิด browser ได้เลย
- tweaks-panel code ถูก inline ไว้ใน index.html แล้ว (ไม่มีไฟล์ .jsx แยก)
- **Hosted:** https://poohriss.github.io/TennisFinderBkk/ (GitHub Pages, auto-deploy on push)
- **Repo:** https://github.com/poohriss/TennisFinderBkk (public, main branch)
- **Git identity (local):** TennisFinder BKK <poohris@gmail.com>

## สถานะปัจจุบัน

- **สนาม Tennis:** 54 สนาม — original 25 (ids 1–30 ยกเว้น 3, 4, 5, 10, 25 dup/closed) + 27 จาก Google Places (ids 31–65 ยกเว้น 34, 36, 44, 45, 50, 51, 58, 59 deleted) + 2 manual (id:66 Let's Play Tennis Rama 2, id:67 Charcoal Court Tennis Club); **id:58 PuunPlus Sport Club deleted (2026-05-23)** — verified badminton-only club (ตลาดพลู, Lemon8 firsthand review: badminton flooring/shoes mandatory/200฿), ไม่มีคอร์ตเทนนิส — Google Places false-positive ใน tennis merge; **id:36 Tennis Courts ประเวศ merged into id:30 สนามกีฬาสวนหลวง ร.9 (2026-05-23)** — pin เทนนิสในสนามกีฬาสวนหลวง ร.9 เดียวกัน; **id:45 สนามเทนนิส SAT merged into id:17 เทนนิส SAT หัวหมาก (2026-05-23)** — สนาม SAT หัวหมากที่เดียวกัน (286 รามคำแหง), เก็บ id:17 (operational ครบ) + rating 4.3/205 + website sat.or.th จาก id:45; **id:34 Spin & Slice merged into id:26 Troops Tennis Academy (2026-05-23)** — rebrand ชื่อเดียวกัน (สุขุมวิท 50), เก็บ id:26 (ชื่อปัจจุบัน); **id:50 สนามเทนนิส วชิรเบญจทัศ + id:51 Tennis Courts สวนรถไฟ merged into id:49 ศูนย์กีฬาวชิรเบญจทัศ (2026-05-19)** — duplicate Google listings ของสวนรถไฟเดียวกัน; GPS verified สำหรับ original หมุดทั้งหมด + photos updated (ids 6, 7, 9, 12, 14, 16, 17, 18, 20, 22, 24, 27, 28, 29, 30); **id:25 Crystal Tennis Center merged into id:40 Crystal Sports G (2026-05-12)** — same physical place; **id:44 Ultra Tennis Studio deleted (2026-05-13)**; **id:5 Santisuk Tennis Court + id:59 Al Fort Tennis & Fitness deleted (2026-05-14)** — ปิดไปแล้ว; **id:30 renamed → Suan Luang Rama IX Sport Center (Prawet)** — verified (เดิม misclassified as Huai Khwang)
- **สนาม Pickleball:** 32 สนาม — original 16 (ids 101–120 ยกเว้น 104, 110, 113, 118, 119 deleted) + 16 ใหม่จาก Google Places (ids 121+ ยกเว้น 126, 128 deleted); **id:104 Shot Selections Beach Café deleted (2026-05-24)** — ปิดไปแล้ว; **id:113 Siangpure Pickleball merged into id:125 Siangpure Tennis Club & Pickleball Club (2026-05-24)** — same venue (127 ซ.โยธินพัฒนา 3 คลองจั่น บางกะปิ), id:113 had wrong GPS (~5km off) + sparse name; เก็บ id:125 (canonical name + correct GPS + place_id + website bertram1958.com + photos); fix id:125 district Lat Phrao → Bang Kapi per Google; **id:126 รับสอน Pickleball หลักสูตรมาตรฐานสากล deleted (2026-05-23)** — coaching service ไม่ใช่คอร์ตจริง; **id:110 Arise Pickleball deleted (2026-05-24)** — Lumpini Tower 16F คือ office ไม่ใช่คอร์ต; Arise's real courts ใช้ partner venues (Asoke=id:108, OnTrack/Thephasadin, Peninsula=id:109) — ไม่ต้องลง pin ซ้ำ; **id:118 Windfield Pickleball deleted (2026-05-24)** — ไม่มีหลักฐานว่ามีคอร์ต pickleball (อาจเป็น tennis-only) — เว็บ/directory ไม่พบ; **id:119 Lat Phrao Pickleball Arena deleted (2026-05-24)** — ไม่พบหลักฐานว่ามีอยู่จริงเลย; **id:128 002 Pickleball Academy deleted (2026-05-24)** — coaching school operating at Beat Discovery (id:102), ไม่ใช่ venue ใหม่
- **Google Places enrichment (2026-05-08):** Merged จาก `bangkok_tennis_courts.json` (46 entries) + `bangkok_pickleball_courts.json` (31) — Tennis matched 11/added 35, Pickleball matched 12/added 19; เพิ่ม field: `place_id`, `photos[]`, `notes`; ส่วนใหญ่ของ photo data + rating/review counts มาจากตรงนี้ (ไม่ใช่ค่าประมาณอีกแล้ว)
- **Rating/Reviews:** สนามที่ matched ใหม่ใช้ Google Places ของจริง; original ที่ไม่ matched ยังเป็นค่าประมาณ
- **googleMaps field:** original 5 ตัว (ids 1, 14, 28, 101, 115) + เพิ่ม place_id ใน 23 สนามจาก enrichment (เปิด Google Maps ผ่าน place_id ก็ได้)
- **website field:** มีแล้ว 26 จาก hand-research + เพิ่มอีก ~30 จาก Google Places enrichment
- **รูปภาพ:** Photos จาก Google Places (มีใน `photos[]` field เกือบทุก court ที่ matched/added) + local override ด้วย `image:` field; priority: `image` > `photos[0]` > gradient+SVG; CourtCard ใช้ thumbnail (=w600-h400), Modal ใช้ full (=w1200-h900) + gallery + attribution (บังคับตาม Google ToS); ตอนนี้ไม่มี local image (โฟลเดอร์ `images/` ว่าง); manual photo URL จาก Google Maps `/p/` หรือ `gps-cs-s` paths ก็ใส่ลง `photos[]` ได้ตรงๆ — strip trailing flag suffix (`-k-no`, `-rw`) แล้วใช้ `=w1600-h1200` เพื่อให้ `resizeGooglePhoto()` ทำงาน
- **ระบบจอง:** ไม่มี ใช้ช่องทางติดต่อ (โทรศัพท์ / website / Google Maps) แทน

## สนามที่ต้องตรวจสอบเพิ่มเติม

### Tennis
- (none)

### Pickleball
- (none — id:110, 118, 119 deleted 2026-05-24 after verification confirmed CLAUDE.md flags)

## Workflow: อัพเดต GPS + Rating จาก Google Maps

ส่ง format นี้ให้ Claude อัพเดตสนามได้ทั้ง GPS, rating, reviews, googleMaps link พร้อมกัน:

```
id:X ชื่อสนาม → https://maps.app.goo.gl/xxx (rating: 4.x, NNN reviews)
```

Claude จะ:
1. Fetch short URL → extract GPS จาก `@lat,lng` ใน redirect URL
2. อัพเดต `lat`, `lng`, `rating`, `reviews`, `googleMaps` ใน COURTS data พร้อมกัน

**หมายเหตุ:** rating/reviews ไม่สามารถ scrape จาก URL ได้ ต้องส่งมาด้วยตนเอง

## Workflow: เพิ่มรูปสนาม

1. หารูปสนาม (Google Maps photos / Facebook ของสนาม / เว็บสนามตรง)
2. crop/resize ratio ~1.6:1 (แนะนำ 800×500 px), save เป็น `.jpg`
3. วางไฟล์ใน `images/` ตั้งชื่อตาม id: `images/court-<id>.jpg` (เช่น `court-1.jpg`, `court-7.jpg`, `court-101.jpg`)
4. เพิ่ม field `image:"images/court-<id>.jpg"` ใน COURTS data ของสนามนั้น
5. ไม่ต้องทำทั้งหมดทีเดียว — สนามไหนไม่มี `image:` ก็ใช้ gradient+SVG ตามปกติ

**Fallback chain:** ถ้า `image:` undefined → gradient+SVG | ถ้า file 404 → onError ซ่อน img → gradient+SVG | ถ้า file ใช้ได้ → แสดงรูป

## Workflow: เพิ่มสนามใหม่ (Tennis หรือ Pickleball)

1. เลือก id ใหม่:
   - **Tennis:** id ถัดไปจาก 30 (เริ่ม 31, 32, ...) — หรือใช้ id ที่ skip (3, 4, 10) ก็ได้ถ้าอยาก reuse
   - **Pickleball:** id ถัดไปจาก 120 (เริ่ม 121, 122, ...)
2. เพิ่ม object ใหม่ใน `TENNIS_COURTS` หรือ `PICKLEBALL_COURTS` array (เรียงตาม id)
3. ใส่ field ครบตามโครงสร้าง (ดู "โครงสร้าง COURTS data" ด้านล่าง):
   - **Required:** id, name, nameTh, district, districtEn, zone, address, type, indoor, nightLights, aircon, courts, priceMin, priceMax, rating, reviews, bts, facilities, hours, phone, featured, lat, lng
   - **Optional:** googleMaps (Google Maps short link), image (`images/court-<id>.jpg`)
4. ตรวจ `zone` ใช้คำตามรายการด้านล่าง (`ใจกลางกรุง`, `สุขุมวิท`, ...)
5. GPS: ดึงจาก Google Maps short link → fetch URL → extract `@lat,lng` จาก redirect URL
6. ถ้าฟรี → `priceMin:0, priceMax:0` → ระบบจะแสดง "ฟรี" อัตโนมัติทุกที่ (card, modal, popup)
7. รูป (optional): ทำตาม "Workflow: เพิ่มรูปสนาม" ด้านบน

ไม่ต้องแก้ filter / map / sort — ระบบ map markers + filter เป็น reactive ทำงานอัตโนมัติ

## Features (Design v3 — Apple — implemented 2026-05-14)

**Visual + Layout (Apple aesthetic):**
- **Typography:** `-apple-system, "SF Pro Display"` + Noto Sans Thai; `.headline` clamp() 48–96px, tight tracking `-0.04em`
- **Palette:** Black/white minimalist + lime accent `#d9e34a` (`--accent`); CSS vars in `:root`; `html.dark` class toggle (only Light + Dark — removed "bold")
- **Page structure (single-scroll, no tabs):**
  1. Fixed blur **Nav** (44px, scroll-aware border, lang switcher, anchor links: Featured / Tennis / Pickleball / Map)
  2. **Hero** (black bg, centered huge headline, live-search pill, CTA links — no sport switcher inside)
  3. **SportShowcase** (gray bg, 2-up Apple-style buttons — text only, no headline/no court panel; click → scroll to sport's list section; compact padding 48px section / 28×30 card inner)
  4. **MapSection** (`#map`, dark, full-width Leaflet with dark CARTO tiles, **price-tier color-coded pins** (`priceTier()`: free=green/≤300=blue/301–700=amber/>700=pink/N-A=gray) with **rating labels** (`court.rating.toFixed(1)`, blank if unrated — เปลี่ยนจาก court id เดิมที่ทำให้งง) + **lime ring = featured**, **sport toggle pill** (Tennis / Pickleball / ทั้งหมด — auto fitBounds), **filter row** (type chips when sport selected + Indoor/AC/Night/BTS toggle pills, reactive markers), **price-tier legend** (bilingual, under filter row), **hero search filters pins** (same predicate as list sections, no auto-fit while typing), **"Near me" geolocation button** (top-right of map, pulse-marker on user location, popup shows distance in km); minimal header: eyebrow + "คลิกหมุดเพื่อดูรายละเอียด")
  5. **Featured carousel** (`#featured`, horizontal scroll, 380px cards using `isFeatured()` helper across both sports)
  6. **Tennis list section** (`#tennis-list`, light bg, type chips + toggles + sort, grid of cards)
  7. **Pickleball list section** (`#pickleball-list`, dark bg, same filter UX; sort `<option>` elements override color to `#000` so OS-native dropdown popup is readable)
  8. **CTA "Ready to play?"** (black, big headline, 2 pill buttons)
  9. **Footer** (gray-bg, copyright + GitHub + back-to-top)
- **Components:** `Nav`, `Hero`, `SportShowcase`, `FeaturedSection`+`CourtCard(featured)`, `CourtListSection`, `CourtCard`, `MapSection`, `CourtDetailModal`, `Footer`
- **CourtSVG:** Sport-aware — `sport="tennis"` draws full tennis layout (alleys, service boxes, T-line); `sport="pickleball"` draws kitchen/non-volley zone (7ft from net) + dashed net + service centerline (does not cross kitchen). Auto-detected via `court.id >= 100` in card/modal call sites.

**Functions preserved (ทั้งหมด — ไม่หาย):**
- **Sort options (per section):** ⭐ แนะนำ (default) / ★ คะแนน / ฿ ราคา / 🎾 คอร์ด / ก–ฮ (Thai) / A–Z (English)
- **Bilingual name swap:** CourtCard + Modal — เมื่อ `lang==="en"` ชื่ออังกฤษอยู่บน
- **Review count display:** CourtCard แสดง `★ 4.5 · NNN` ถัดจาก rating
- **Live search:** Hero search ใช้ `searchQ` state ที่ส่งเข้า list sections — พิมพ์ใน hero → filter ทันที, ปุ่ม/Enter → scroll ไป `#<sport>-list`
- **Multi-type courts:** `type` รับ string หรือ array; helpers `courtTypes/primaryType/courtHasType`
- **Map view:** Leaflet + dark CARTO tiles, custom pin markers (**price-tier color fill via `priceTier()` + rating label `court.rating.toFixed(1)`, lime ring if featured**) + bilingual price legend, **sport-filter pill** (mapSport state — "all" | "tennis" | "pickleball", **default = "tennis"**, auto `flyToBounds` when switching), **filter row** (type chips + Indoor/AC/Night/BTS toggle pills, reactive markers, filterType auto-resets to "all" when sport switches) **+ hero `searchQ` filters markers too** (same predicate as list, no auto-fit while typing), **geolocation** via `navigator.geolocation.getCurrentPosition` → pulse-blue user marker + `haversineKm()` distance displayed in popup eyebrow; split useEffect + markersRef reactive pattern
- **Detail modal:** Apple-style — gradient header, photo gallery + arrow keys + attribution row; 2×2 info grid (price/hours/rating/courts); facilities pills; 3 pill buttons (phone / website / Open in Maps); `body.style.overflow="hidden"` lock
- **Featured (⭐ แนะนำ):** manual selection via `featured:true` field ใน court data (เดิม auto-compute จาก rating+reviews แต่เปลี่ยนเป็น manual 2026-05-18) ผ่าน `isFeatured(court)`; populates the Featured carousel + lime ring บน map markers. ปัจจุบัน 12 courts: tennis 1,6,7,21,24,28,40,66 + pickleball 101,102,106,112
- **Free court display:** `priceMin===0` → แสดง "ฟรี" / "Free"
- **Language:** ไทย / EN toggle ใน nav (Apple pill) + ใน tweaks panel — share `lang` state
- **Tweaks panel:** Floating draggable (Light/Dark + ไทย/EN — simplified from v2)
- **Website button:** Pill in modal between phone + Open in Maps
- **CourtSVG:** Landscape orientation

## สิ่งที่วางแผนจะทำ

- [ ] เพิ่ม local รูปภาพ override (`image:` field) — มี id:1 แล้ว; courts ส่วนใหญ่ใช้ Google Places photos อัตโนมัติ ไม่จำเป็นต้องเพิ่ม local เว้นจะอัปเกรดคุณภาพ
- [x] ระบบรูปภาพ — `image:` field + fallback (CourtCard + Modal)
- [x] เพิ่ม website field + ปุ่ม 🌐 ใน modal — 26 สนามมีแล้ว (Tennis 18, Pickleball 8)
- [x] ปุ่ม TH/EN ใน nav bar + bilingual filter bar (type pills, text toggles, sort, reset)
- [x] Git + GitHub Pages — auto-deploy on push
- [ ] อัพเดต rating/reviews + googleMaps link ทุกสนาม — ส่ง format นี้ให้ Claude: `id:X ชื่อ → https://maps.app.goo.gl/xxx (rating: 4.x, NNN reviews)`
- [x] Verify aircon สนามที่ยังไม่แน่ใจ — **resolved 2026-06-06**: Club 46 (id:103), Suk Space (id:107), Windfield Tennis (id:14), CV Sport (id:11) = ลง aircon:false อยู่แล้วทั้งหมด ✓. Beat Discovery resolved: ventilated/high roof (aircon:false). Arise removed (id:110 deleted). ดู batch "Aircon audit" ด้านล่าง
- [x] Verify / แก้ไข ids 110, 118, 119 (pickleball) — ทั้ง 3 ลบทิ้ง (2026-05-24): id:110 Lumpini Tower เป็น office, id:118/119 ไม่มีหลักฐาน
- [x] Verify ids 29, 30 (tennis GPS/district) — id:29 Grand Tennis GPS verified, id:30 renamed → Suan Luang Rama IX (Prawet)
- [x] Verify และเพิ่มข้อมูล Pickleball courts (20 สนาม, ids 101–120)
- [x] GPS verify รอบ 2 — แก้ pickleball 7 หมุด, เปลี่ยน id:120 เป็น Slowcombo
- [x] Filter bar redesign — เอา zone pills ออก, เพิ่ม aircon/indoor เป็น text pills
- [x] Sport tabs ย้ายลงมาอยู่เหนือ filter bar
- [x] Map view — sport tabs + reactive markers เมื่อเปลี่ยน sport
- [x] GPS verify + แก้ไข 12 หมุดผิด + ลบ 3 duplicate courts (tennis)
- [x] Sort ตัวอักษร — ก–ฮ (Thai) และ A–Z (English)
- [x] googleMaps field — ถ้ามี link จะ redirect ตรง, ถ้าไม่มี fallback เป็น search by name+address
- [x] Default sort = ⭐ แนะนำ (featured ขึ้นบนเรียงตาม rating, ที่เหลือเรียงตาม rating)
- [x] Bilingual name swap — `lang==="en"` ชื่ออังกฤษอยู่บนใน CourtCard + Modal
- [x] Review count ใน CourtCard — แสดง `(NNN)` ถัดจาก rating
- [x] เพิ่ม id:66 Let's Play Tennis Court Rama 2 (บางขุนเทียน, ฟรี/350฿, 06:00–22:00)
- [x] Sterling pricing update (2026-05-12) — Tennis id:31: 1,100–1,400฿ + hours + BTS + facilities; Pickleball id:106: 890–990฿ (Club tier จาก sterlingbkk.com/privilege-tiers)
- [x] Crystal Sports G — merge id:25 Crystal Tennis Center → id:40 (เป็นสถานที่เดียวกัน), keep operational data จาก id:25 (8 courts, 500–600฿, 06:00–22:00, rating 4.8/110, 4 photos รวม)
- [x] Hero search live-filter (2026-05-13) — Hero ใช้ `searchQ` state เดียวกับ filter bar, พิมพ์แล้ว filter ทันที, ปุ่ม/Enter → scroll
- [x] Multi-type schema (2026-05-13) — `type` รับ array `["hard","clay"]`, รองรับสนามที่มีหลายพื้นผิว (เช่น ALM x IMPACT มีทั้ง hard + clay)
- [x] id:7 IMPACT rebrand → **ALM x IMPACT Tennis & Sport Center** (2026-05-13) — multi-type, GPS verified, ราคา 300–1,500฿ (US Open hard / Australian Open hard / Center Court / Clay), hours 08:00–22:00, photo, googleMaps
- [x] id:39 Crystal Sports detailed update (2026-05-13) — 8 courts, 400–600฿, 06:00–00:00, indoor + aircon, Laykold surface (US Open grade), ITF certified
- [x] Photo updates (2026-05-13) — id:6 Peninsula (เว็บไซต์ peninsula.com), id:24 FBT Pyramid (Photo Sphere + GPS corrected), id:28 Ace of Clubs (Google /p/), id:7 ALM x IMPACT (Photo Sphere)
- [x] Delete id:44 Ultra Tennis Studio (2026-05-13) — tennis count 62 → 61
- [x] Delete `images/court-1.jpg` + ลบ field `image:` ใน id:1 — ใช้ `photos[0]` (Google Places) แทน, โฟลเดอร์ `images/` ว่าง
- [x] Delete id:5 Santisuk + id:59 Al Fort (2026-05-14) — สนามปิดไปแล้ว
- [x] Add id:67 Charcoal Court Tennis Club (2026-05-14) — บางกรวย Nonthaburi, 3 tennis + 2 pickleball, 24-hour, 250–690฿, GPS 13.8094/100.4376
- [x] id:30 rename → **Suan Luang Rama IX Sport Center** (2026-05-14) — เปลี่ยน district: ห้วยขวาง → ประเวศ, GPS corrected to 13.6819/100.6600, zone: ใจกลางกรุง → ฝั่งตะวันออก
- [x] Photo batch update (2026-05-14) — 11 courts: ids 9, 12, 14, 16, 17, 18, 20, 22, 27, 29, 30 (Google Maps Photo Spheres)
- [x] Remove broken website (id:19 Simoorgh — bkktennis.com offline)
- [x] **Design v3 — Apple redesign** (2026-05-14) — full visual + layout rewrite from claude.ai/design "TennisFinder Apple" bundle. SF Pro typography, black/white + lime accent (`#d9e34a`), single-scroll Apple layout (Nav → Hero → Featured carousel → SportShowcase → Tennis section → Pickleball section → Map → CTA → Footer). New components: `Nav`, `FeaturedSection`, `SportShowcase`, `CourtListSection`, `Footer`. Modal Apple-style with 2×2 info grid + pill buttons. Map uses dark CARTO tiles with numeric pin labels. **All data + functions preserved** — 60+39 courts untouched, photos gallery + attribution, googleMaps redirect, multi-type, live search, sort options, filter chips/toggles, tweaks panel
- [x] **Map upgrades** (2026-05-16) — (1) **Sport toggle pill** on map (Tennis / Pickleball / ทั้งหมด) — `mapSport` state, auto `flyToBounds` when filter changes (skips "all"). (2) **Geolocation** — "Near me / ใกล้ฉัน" white pill button positioned `top:8px right:28px` (tucked into the rounded top-right corner of the map), blue pulse-marker on user location, popup eyebrow shows distance via new `haversineKm()` helper; bilingual error toast (red box under button) for permission denied / unavailable / timeout. MapSection now receives `tennisCourts` + `pickleballCourts` as separate props (was combined array). Tried marker clustering (leaflet.markercluster) but reverted — user felt clusters made the map harder to read. **Note:** geolocation works on HTTPS (GitHub Pages) — on local `file://` Chromium may block silently
- [x] **Layout polish** (2026-05-18) — (1) **MapSection ย้ายขึ้น** ระหว่าง SportShowcase กับ Featured carousel (เดิมอยู่ก่อน CTA) — discovery flow: เลือกกีฬา → ดูแผนที่ → ดู featured → list. (2) **SportShowcase compaction** — section padding 80→48px, card inner 48×44 → 28×30, heading 44→32px, subhead 18→15px, border-radius 32→24. (3) **Pickleball sort dropdown** — เพิ่ม `style={{color:"#000"}}` ใน `<option>` elements เพื่อให้ OS-native dropdown popup อ่านได้ (ก่อนหน้า white-on-white)
- [x] Verify rating/reviews — ids 66 (4.9/8), 67 (5.0/3), 28 (4.1/140), 40 (4.5/51), 20 (4.5/116) — ongoing
- [x] **Suan Rot Fai dedup** (2026-05-19) — merge id:50 + id:51 → id:49 ศูนย์กีฬาวชิรเบญจทัศ (สวนรถไฟ); enrich id:49: courts:7, 80฿/hr, 06:00–20:00, CSTD Smart app booking, knock board + parking. Tennis 60 → 58
- [x] **Enrich id:65 Phuti Anant Bang Na** (2026-05-19) — Royal Thai Navy welfare complex: courts:4, hours 07:00–21:00 (จ–ศ), full facilities. Price not published. id:32 The Racquet Club: day pass 495–595฿ + courts:7 + indoor:true + hours. id:20 Thana City + id:32 RQ googleMaps links added
- [x] **Featured carousel manual selection** (2026-05-18) — `isFeatured()` เปลี่ยนจาก auto-compute (rating≥4.6 && reviews≥100) เป็น manual `court.featured===true` ผ่าน field ใน data; ลบ subhead "คัดอัตโนมัติจาก rating ≥ 4.6..." ออกจาก FeaturedSection. ปัจจุบัน 12 courts flagged (id:2 ถอนออก, id:66 เพิ่ม 2026-05-19): tennis 1,6,7,21,24,28,40,66 + pickleball 101,102,106,112 — แก้ `featured` field ใน data เพื่อ adjust list ได้
- [x] **Map filter row** (2026-05-18) — เพิ่ม type chips (Hard/Clay/Grass สำหรับ tennis, Hard สำหรับ pickleball, ซ่อนเมื่อสลับเป็น "ทั้งหมด") + 4 toggle pills (Indoor/AC/Night/BTS) ใต้ sport toggle. `mapFilterType` reset เป็น "all" อัตโนมัติเมื่อสลับกีฬา. ไม่มี auto-fitBounds เมื่อ filter เปลี่ยน (จะกระตุกเกินไป), แค่ markers reactive ผ่าน useEffect deps. Pickleball label localized to "พิกเคิลบอล" เมื่อ lang=th
- [x] **Map default sport = "tennis"** (2026-05-18) — เปลี่ยนจาก "all" ตอนแรกเป็น "tennis" — user เปิดมาเห็นแค่หมุดเทนนิสก่อน, กดสลับ "ทั้งหมด"/"พิกเคิลบอล" ได้
- [x] **Map: search-filtered pins + price-tier pin colors** (2026-05-24) — (1) **Hero search กรองหมุดด้วย** — ส่ง `searchQ` เข้า MapSection, ใช้ predicate เดียวกับ CourtListSection (nameTh/name/district/zone) → พิมพ์ค้นหาแล้วหมุดบนแผนที่กรองทันที (ไม่มี auto-fitBounds ระหว่างพิมพ์ กันกระตุก). (2) **Price-tier pin styling** — helper `priceTier(court)` map `priceMin` → สีหมุด (ฟรี=เขียว #30a46c / ≤300฿=น้ำเงิน #0a84ff / 301–700฿=ส้ม #f5820a / >700฿=ชมพู #ff375f / ไม่ระบุ=เทา #8e8e93), เลขสีขาว. **featured ย้ายจาก lime fill → lime ring** (`box-shadow:0 0 0 3px #d9e34a`) เพื่อไม่ชนกับสี tier. (3) **Legend** bilingual ใต้แถว toggle filter (5 สี + แหวน lime = แนะนำ). ทั้งหมด client-side, ไม่มี dep ใหม่ (markers reactive ผ่าน `courts` ที่ recompute). **Verify note:** headless Edge/Chrome dump คืน 0-length DOM ใน sandbox นี้ (crashpad killed) — verify ด้วย manual JSX review แทน
- [x] **Map pin label = rating** (2026-05-24) — เปลี่ยนเลขในหมุดจาก court id (1–67 / id−100) ซึ่ง user บอกว่า "งง" → **Google rating** (`court.rating.toFixed(1)`, font 10px bold, ว่างถ้าไม่มี rating → เป็น dot สีเปล่า), tooltip `★ x.x`. อัปเดต map subhead: "ตัวเลขในหมุด = คะแนนรีวิว ★ · สี = ราคา"
- [x] **Tennis price-hunt batch** (2026-05-24) — เน้นหา price ของสนามที่ยังไม่มี priceMin. **id:62 Rungsang Tennis** — promote 350฿/hr จาก note → `priceMin:350, priceMax:350`; เติม courts:9 (1 damaged), bts:"BTS บางจาก", facilities (lights/pool/coaching/hitting partner), address แก้เป็น 85 Soi Bang Na-Trat 1, email rungsang9court@gmail.com. **id:64 Spinning J** — promote ~500฿/hr จาก note → `priceMin:500, priceMax:500`; fix address typo "Lasan 42" → "Lasalle 42". **id:38 PR Dept Tennis** — เติม courts:2 + notes (evening reserved for govt employees, no water/restrooms, 7-Eleven nearby) จาก primaltennis guide; ราคา/hours ไม่ published. **No published data found:** id:43 ปัญจบุตร, id:55 Itsaraphap, id:60 Hatch, id:63 Simoorgh Bang Na 12 (sister branch, ข้อมูล published เฉพาะ main Sukhumvit 56) — ปล่อยตาม notes เดิม. **Honest take:** courts ที่ยังไม่มี priceMin (19 หลัง batch นี้) ส่วนใหญ่เป็น government welfare/private academies/new venues ที่ตั้งใจไม่ publish flat rates online; ต้อง contact โดยตรง. แหล่ง: primaltennis, tennisbangkok, liga.tennis
- [x] **Pickleball cleanup batch** (2026-05-24) — verify ที่เหลือ + ลบ 4 entries ไม่ valid: (1) **id:110 Arise** — เช็ค arisepickleball.com/courts: "Lumpini Tower 16F" = office ของ Arise ไม่ใช่คอร์ต; real courts = Asoke (id:108), OnTrack/Thephasadin (BTS National Stadium), Peninsula (id:109) — ลบ. (2) **id:128 002 Academy** — coaching school at Beat Discovery (id:102) ที่อยู่เดียวกัน (Soi Sukhumvit 66) — ลบ (pattern เดียวกับ id:126). (3) **id:118 Windfield** + **id:119 Lat Phrao Arena** — ไม่มีหลักฐานว่ามีคอร์ตจริงเลย CLAUDE.md flag ถูก — ลบ. **Enriched id:132 Nawamin LanPat 1 Park** — ฟรี public BMA park, 06:00–21:00, no reservation. **Left as-is** id:131 MAD DUCK, id:133 Pickle Park 22, id:135 PICKLE CLUB (มี place_id+photos+rating = real venues, just thin web presence — review-based notes เดิมพอ). Pickleball 38→34. แหล่ง: arisepickleball.com, pickleballgather.com
- [x] **Mobile critical fixes** (2026-05-19) — (1) **Nav** anchor links wrapped in `.nav-links` class, hidden at `max-width: 640px` (logo + lang switcher stay visible). (2) **SportShowcase** grid `1fr 1fr` → `repeat(auto-fit, minmax(300px, 1fr))` — auto-stack to 1 column บน mobile. (3) **Section padding** — เพิ่ม `.section-pad` (desktop 100/120 → mobile 56/64) + `.hero-pad` (desktop 120/60 → mobile 80/40) applied to MapSection / FeaturedSection / CourtListSection / CTA / Hero. ลด vertical whitespace ~40% บน mobile. ไม่กระทบ desktop
- [x] **Court enrichment batch** (2026-05-23) — verified/added operational data จาก official sites + web search: id:47 ศิริพจน์ (4 courts, 180/280฿, 06:00–24:00, BTS เสนานิคม, buffet promo), id:48 P21 Rooftop (2 courts ชั้น 11, 07:00–21:00, ราคาไม่ published), id:42 Siangpure Tennis (2 acrylic, 250/350฿) + id:125 Siangpure Pickleball (2 asphalt, ฟรี), id:33 APF (2 indoor plexipave AO-grade, 800/900฿, lessons 1,500–2,200฿, 08:30–18:00, founder Hideki Kaneko), id:54 Momo (indoor warehouse, 24h, 600/700฿, lessons 1,300฿), id:16 Hilton Grande Asoke (ยืนยันมีคอร์ตจริง + photo update), id:52 Supalai Park Sports Club (multi-sport club ในคอนโด พหลฯ 21: tennis/squash/ปิงปอง/ฟิตเนส/สระ/ซาวน่า/มวยไทย + BTS พหลโยธิน 24; ราคา/courts/hours ไม่ published — ~200฿ unverified note), id:46 สนามเทนนิส ม.รามคำแหง (สำนักกีฬา RU หัวหมาก: 6 floodlit hard courts, 06:30–20:30 ทุกวัน, สมาชิกปีละ 20฿ + ราคา/ชม. ตามประเภทสมาชิก ~80–220฿, ARL รามคำแหง, LINE @476fpabv), id:35 KS Sport Club (private tennis ปรีดี พนมยงค์ 42/สุขุมวิท 71: 8 floodlit hard courts, ศาลาพัก/ร้านเครื่องดื่ม/pro shop, ราคา+hours ไม่ published, FB kstenniscourt — NOT ks-tennis.com ซึ่งเป็นเว็บเยอรมัน), id:37 สนามเทนนิสศิริสุข tennis entry (เติมจาก same-venue pickleball id:111: 4 floodlit hard + 2 pickleball cross-listed, 06:00–23:00, ครูสอน/เช่าอุปกรณ์/จอดรถ, BTS ช่องนนทรี, ~300–400฿ approximate), id:53 สโมสรอยู่เจริญ (สาขาวิภาวดี ซ.20 จอมพล จตุจักร: tennis/ฟิตเนส/สระ/ซาวน่า, MRT ลาดพร้าว ~800m, ~250฿ คอร์ทเก่ามีรอยร้าว; courts/hours ไม่ published — **ระวังมีหลายสาขา** ดินแดง 02-641-9001-5 + รัชดาซ.3 เป็นคนละที่). **Pattern:** courts ที่ไม่มีราคา published → ไม่เดา, ใส่ notes "contact directly" + cite source ใน notes
- [x] **Pickleball enrichment batch** (2026-05-23) — เติมข้อมูล Google Places additions (id:121–139) ที่ facilities ว่าง: **id:124 Pick A Court** (6 indoor AC, 750฿, 08:00–22:00, open play พ/ศ/ส 280฿/คน, aircon→true), **id:122 Backyard Pickleball** (4 outdoor courts, 400฿, racket 100฿, ครูสอน/จอดรถ, อุดมสุข), **id:129 PlayBox** (2 outdoor courts ชั้น 11 Suntowers, 400฿, 24h), **id:130 Rujiseri** (~300฿, 06:00–23:00, จอง skedda, ไม่มีหลังคา), **id:121 OH My Court** (06:00–22:00, tennis+pickleball ลาดกระบัง, courts/ราคาไม่ published), **id:123 Rally57** (indoor + เช่ารองเท้า; ราคา/hours ไม่ published), **id:134 Pickleball or die** (15:00–20:00, ครูสอน). **Flags:** id:127 Happy Sports Club 18 = 15-rai multi-sport (ฟุตบอล/แบด/ฟิตเนส/มวย/ปาเดล) — **pickleball ยืนยันไม่ได้** จาก official sources (อาจเล่นบนคอร์ตแบด) ใส่ note เตือน; id:128/131/132/133/135 = venue เล็ก/ใหม่ (0–7 reviews) ไม่มีข้อมูล published ปล่อยตาม note เดิม. **id:126 รับสอน Pickleball = coaching service ไม่ใช่คอร์ต → ลบแล้ว** (pickleball 39→38). **Outside-BKK 4 สนาม** (ปริมณฑล): id:136 Pickleball Warehouse (12 indoor courts ลำลูกกา/รังสิต, 200–400฿, 08:00–21:00, indoor→true), id:138 Smash! (3 pickleball + 9 badminton บางแก้ว, 300฿ ก่อน 16:00 / 400฿ หลัง, Pro Shop), id:139 S9 (3 indoor acrylic สำโรงเหนือ, 99฿/คน open-play, indoor→true), id:137 The Primary (6 courts บางแก้ว, ใหม่ ราคา/hours ไม่ published). แหล่ง: pickleballinthailand/pickleballplusapp/Pickleheads/Lemon8/FB
- [x] **Polish batch — hero strip + pickleball cleanup/photos/dedup** (2026-05-24, continued) — multi-fix follow-up:
  - **Hero strip** — ลบ subhead `<p>` (`${courtCount} ${sport} clubs and public courts. All in one place. Built for Bangkok.` / `${courtCount} สนาม${sport} ในที่เดียว ครบทุกเขต ทำมาเพื่อคนกรุงเทพฯ`) + ลบ italic side-project note ที่เพิ่งใส่ออก. Hero เหลือ eyebrow → headline → search → CTA. Search bar marginTop 30→60, animationDelay 0.24s→0.2s. Court count ยังโชว์ใน list section titles อยู่
  - **SportShowcase pickleball title** — match tennis pattern: "Pickleball is here. And it's growing fast." → "Pickleball in Bangkok. From ฿{min} / hour." (`Math.min(...PICKLEBALL_COURTS.map(c=>c.priceMin).filter(p=>p!=null&&p>0))`)
  - **id:139 S9 priceMin cleared** — 99฿/person คือ open-play per-person ไม่ใช่ per-hour; ออกจาก field เพื่อไม่ให้ SportShowcase title โชว์ "From ฿99 / hr" misleadingly. Min pickleball ตอนนี้ = ฿200 (id:108 Asoke)
  - **Pickleball photos added** — id:109 Peninsula (peninsula.com official), id:105 Santisuk + id:114 Panya + id:120 Slowcombo (Google Maps `gps-cs-s` paths from user-supplied share URLs, -k-no flag stripped, =w1600-h1200)
  - **Pickleball GPS fixes** — id:105 Santisuk 13.7723→13.7709862 (~300m), id:120 Slowcombo 13.7330→13.734574 (~175m)
  - **id:113 Siangpure Pickleball merged into id:125** — same venue (127 ซ.โยธินพัฒนา 3 คลองจั่น บางกะปิ); id:113 had wrong GPS ~5km off + sparse name. Keep id:125 (canonical name + correct GPS + place_id + bertram1958.com + photos). Fix id:125 district Lat Phrao → Bang Kapi per Google. Pickleball 34→33
  - **id:104 Shot Selections Beach Café deleted** — ปิดไปแล้ว. Pickleball 33→32
  - **Tennis hotel phones added** — id:6 Peninsula +66 2 020 2888, id:16 Hilton Grande Asoke +66 2 204 4000
- [x] **Missing-data fill batch** (2026-06-06) — web-research เติม field ที่ขาด จากแหล่งทางการ: **id:123 Rally57** — courts:4, priceMin/Max:550฿/hr, hours 06:00–24:00, website rally57club.com (จากเว็บทางการ; phone มีอยู่แล้ว). **id:122 Backyard** — เติม hours 08:00–22:00 (pickleballgather), update note. **id:105 Santisuk** — เพิ่ม website santisuk.org + แก้ hours อาทิตย์ 14:00–19:00 → **15:00–19:15** ตามเว็บทางการ. **id:67 Charcoal** — เพิ่ม phone +66 64 201 2204 (จาก charcoalcourt.com). **ไม่พบข้อมูล published** (ปล่อยตาม pattern): OH My Court (id:121), The Primary (id:137), Let's Play Rama 2 phone/courts (id:66), SP Pickleball website (id:117), S9 hours (id:139). **Note:** id:105 Santisuk เว็บทางการระบุค่าเล่น 50฿/คน/วัน (+10฿/คน/ชม. ไฟกลางคืน) ซึ่งเป็นคนละ pricing model (donation per-person-per-day ของ church/school court) — **user ตัดสินใจคง priceMin:200 ไว้ตามเดิม** (ไม่ใส่ 50 เพราะจะ misleading ใน SportShowcase "From ฿X/hr").
- [x] **Crystal Sports aircon fix** (2026-06-06) — id:39 Crystal Sports + id:40 Crystal Sports G: `aircon:true → false` (user firsthand + เว็บทางการ crystalsports.kegroup.co.th ชูจุดขาย "ceiling height / better airflow" ไม่มี A/C เลย — indoor แบบมีหลังคา+ระบายอากาศ ไม่ใช่แอร์ pattern เดียวกับ Beat Discovery). facilities "แอร์" → "ระบายอากาศ (เพดานสูง)" ทั้งสอง. **Cross-check:** บทความ KTC "10 indoor tennis ติดแอร์" เขียน "Crystal Park (เลียบด่วน) - แอร์" แต่รีวิว lemon8 จริง + เว็บทางการไม่พูดถึงแอร์ → "Crystal Park" น่าจะคนละที่/จัดหมวดหลวม, ยืนยัน false ถูกต้อง
- [x] **Aircon audit — tennis aircon:true ทั้งหมด** (2026-06-06) — ไล่เช็คทุกสนามที่ลง aircon:true ตาม user belief ("มีแต่ Noah กับ Sterling ที่มีแอร์"):
  - **id:21 Noah BKK@26** — เว็บทางการ noahbkk.com ยืนยัน "two **air-conditioned** artificial turf indoor courts + 4 outdoor hard" → aircon:true ถูก ✓; แก้ indoor:false → **true** (เดิม inconsistent เพราะมีคอร์ต indoor AC จริง)
  - **id:31 Sterling** (tennis) + **id:106 Sterling** (pickleball) — user confirmed มีแอร์, premium wellness club, คง aircon:true ✓
  - **id:29 Grand Tennis Club** → `aircon:true → false` — FB ทางการ + KTC list ไม่พูดถึงแอร์เลย (สนาม indoor ที่มีแอร์จริงจะโฆษณาเป็นจุดขายเสมอ); brand เป็น "สนามเทนนิสในร่ม" แต่ = covered/ventilated. facilities "แอร์" → "ระบายอากาศ"
  - **id:67 Charcoal** → `aircon:true → false` — เว็บทางการ charcoalcourt.com ระบุ Court 1 = "สนามในร่ม (เปิดโล่ง)" semi-indoor เปิดโล่ง ไม่มีแอร์. facilities "แอร์" ออก, "คอร์ตในร่ม (1)" → "คอร์ตในร่ม เปิดโล่ง (1)"
  - **Pickleball aircon:true** — id:112 Papaya = **confirmed AC** (architizer: "fully air conditioned, 6 indoor courts", รีโนเวตจากสนามฟุตบอล) ✓; id:108 Asoke + id:124 Pick A Court = documented AC ✓; **id:116 Dink A Lot = confirmed AC** (user firsthand เคยไปแล้ว) ✓ aircon:true ถูก; **id:115 RSC Ratchaphruek = ยังไม่ verify** (indoor acrylic พรีเมียมน่าจะมีแต่เว็บไม่ระบุ) — ปล่อย aircon:true ไว้ก่อน แหล่ง: rally57club.com, santisuk.org, charcoalcourt.com, pickleballgather, thaicourts

## โครงสร้าง COURTS data

### Tennis (TENNIS_COURTS — ids 1–67 ยกเว้น 3, 4, 5, 10, 25, 34, 36, 44, 45, 50, 51, 58, 59, total 54 courts)
```js
{
  id, name, nameTh, district, districtEn, zone,
  address, type,        // "hard" | "clay" | "grass" | array เช่น ["hard","clay"] สำหรับสนามหลายพื้นผิว
  indoor, nightLights, aircon,  // boolean
  courts,               // จำนวนคอร์ด
  priceMin, priceMax,   // บาท/ชั่วโมง
  rating, reviews,      // Google Maps rating — รอ verify
  bts,                  // string | null
  facilities,           // string[]
  hours, phone,
  featured,             // boolean — แสดงใน hero
  lat, lng,             // GPS สำหรับ Leaflet map
  googleMaps,           // string | undefined — Google Maps short link (maps.app.goo.gl/xxx)
                        //   ถ้ามี → redirect ตรงไปสนาม | ถ้าไม่มี → fallback search by nameTh+address
                        //   ใช้อัพเดต GPS + rating พร้อมกันได้: format "id:X → link (rating: 4.x, NNN reviews)"
  image,                // string | undefined — local override path เช่น "images/court-1.jpg"
                        //   ถ้ามี + โหลดได้ → แสดงรูป (cover) | ถ้าไม่มี/404 → fallback ไป photos[0] หรือ gradient+CourtSVG
  website,              // string | undefined — URL เว็บไซต์ของสนาม เช่น "https://www.cozytennis.com/"
                        //   ถ้ามี → แสดงปุ่ม 🌐 เว็บไซต์ ใน detail modal (ระหว่างปุ่มโทรศัพท์กับ Google Maps)
  place_id,             // string | undefined — Google Places ID (จาก enrichment); ใช้ match ใน merge ครั้งหน้า
  photos,               // [{url, attribution:{name, profile_url}}] | undefined — รูปจาก Google Places
                        //   URL มี size suffix `=s4800-w800-h600` — ใช้ resizeGooglePhoto() เปลี่ยนเป็น =wXXX-hYYY
                        //   Attribution บังคับแสดงใต้รูปทุกรูป (ตาม Google ToS)
  notes,                // string | undefined — หมายเหตุภาษาอังกฤษจาก Google enrichment
}
```

### Pickleball (PICKLEBALL_COURTS — ids 101+)
```js
{
  id, name, nameTh, district, districtEn, zone,
  address, type,        // "hard" | "synthetic"
  indoor, nightLights, aircon,  // boolean
  courts,               // จำนวนคอร์ด pickleball
  priceMin, priceMax,
  rating, reviews,      // Google Maps rating — รอ verify
  bts,
  facilities,
  hours, phone,
  featured,
  lat, lng,
  googleMaps,           // string | undefined — เหมือน tennis
  image,                // string | undefined — เหมือน tennis
  website,              // string | undefined — เหมือน tennis
}
```

## ข้อมูลสนามสำคัญที่แก้ไขแล้ว (Pickleball)

| id | ชื่อ | สิ่งที่แก้ |
|----|------|-----------|
| 101 | Benchakitti Sport Complex | GPS corrected + googleMaps added |
| 102 | Beat Discovery | GPS corrected |
| 103 | Club 46 | GPS corrected (ผิดเกือบ 3km ใน lat เดิม) |
| 106 | Sterling Court | phone→091-742-6222, hours→23:30 |
| 107 | Suk Space | district→วัฒนา, address→14/1 ซ.สุขุมวิท 67, courts→8 |
| 108 | Asoke Sports Complex | GPS corrected |
| 111 | Sirisuk Pickleball | GPS corrected, phone→081-924-8555 |
| 114 | Panya Indra | GPS minor correction |
| 115 | RSC Ratchaphruek | GPS major correction (~3km off) + googleMaps added |
| 120 | **Slowcombo** (เปลี่ยนจากสนามปลอม) | 126 ซ.จุฬาลงกรณ์ 50 วังใหม่ ปทุมวัน, 2 outdoor courts, ฟรี (ซื้อเครื่องดื่ม), 080-914-4565, 10:00-20:00; **2026-05-24** GPS +175m corrected + photo added |
| 105 | Santisuk | **2026-05-24** GPS +300m corrected (13.7723→13.7709862) + photo added |
| 109 | The Peninsula Bangkok | **2026-05-24** photo added (peninsula.com official) |
| 114 | Panya Sport Complex | **2026-05-24** photo added |
| 125 | Siangpure Tennis & Pickleball Club | **2026-05-24** merge target ของ id:113 (deleted); district Lat Phrao → Bang Kapi per Google; postal 10230→10240; bts:"Bangkapi (Yellow Line)" |

## Zones ที่ใช้

`ใจกลางกรุง` / `สุขุมวิท` / `ฝั่งตะวันออก` / `ฝั่งเหนือ` / `ริมแม่น้ำ` / `ฝั่งใต้` / `ฝั่งตะวันตก`

## Workflow: re-merge enriched JSON (Google Places refresh)

ถ้ามี JSON enrichment ใหม่ (`bangkok_tennis_courts.json` / `bangkok_pickleball_courts.json` regenerated):

```powershell
# จาก project root (Windows PowerShell 5.1)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
& .\merge.ps1
```

`merge.ps1` จะ:
1. Read existing arrays จาก `index.html` (UTF-8) — extract via regex
2. Read JSON enrichment files
3. Match: name (normalized) → GPS proximity (<150m strong, 150–500m + shared keyword)
4. Merge: JSON wins on overlap fields; existing-only fields (priceMin, hours, bts, etc.) preserved
5. Add unmatched JSON courts as new entries (Tennis id starts 31, Pickleball id starts 121)
6. Re-write `TENNIS_COURTS` / `PICKLEBALL_COURTS` arrays in `index.html` (single-line per court)

Outputs intermediate `merged_*.json` for debugging (not committed).

**หมายเหตุ:**
- Script reads/writes UTF-8 explicitly; Thai characters preserved
- Null fields skipped in JS literal output (keeps file lean) — UI must handle missing fields
- Re-running is idempotent: matches already-merged courts via `place_id` (after first run)

## Git workflow

```bash
git status
git add <files>
git commit -m "message"
git push                    # auto-deploy ขึ้น GitHub Pages ใน ~10-30 วิ
```

- Branch: `main` (track `origin/main`)
- ทุก push GitHub Pages rebuild + deploy ใหม่อัตโนมัติ
- `.gitignore` ครอบคลุม OS files, IDE, `.claude/` (user-specific)
- Repo เป็น **public** — ห้าม commit secrets/API keys

## Debugging white-screen / runtime errors (headless Edge)

ถ้าเปิดเว็บแล้วเห็นจอขาว (Babel ไม่ throw แต่ React render ไม่ขึ้น) — capture console errors แบบ headless:

```powershell
$msedge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$logFile = "$env:TEMP\edge-log.txt"
$tmpProfile = "$env:TEMP\edge-test-$(Get-Random)"
& $msedge --headless --disable-gpu --user-data-dir=$tmpProfile `
  --allow-file-access-from-files --enable-logging "--log-file=$logFile" --v=0 `
  "file:///C:/Users/poohr/Desktop/TennisFinderBkk/index.html" `
  --virtual-time-budget=15000 --dump-dom > $null
Get-Content $logFile | Select-String 'Uncaught|Error|TypeError' | Where-Object { $_ -notmatch 'GetGpuDriver|task_manager|extensions|oneauth' }
Remove-Item -Recurse -Force $tmpProfile
```

`--virtual-time-budget=15000` รอ 15 วินาทีให้ JS รัน; console.error/Uncaught errors จะอยู่ใน log file
- ใช้แก้ปัญหา id:1 case (StarRating crash บน rating=null) — debug ภายใน 1 รอบ

## Map markers pattern (Leaflet + React)

```js
// split useEffect เพื่อให้ markers reactive
useEffect(() => { /* init map once */ }, []);
useEffect(() => {
  // clear old markers
  markersRef.current.forEach(m => m.remove());
  markersRef.current = [];
  // add new markers
  courts.forEach(court => { ... markersRef.current.push(m); });
}, [courts, sport]); // re-runs when sport changes
```
