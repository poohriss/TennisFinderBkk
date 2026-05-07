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

- **สนาม Tennis:** 27 สนามจริงในกรุงเทพฯ (ids 1–30 ยกเว้น 3, 4, 10 ที่เป็น duplicate) — ข้อมูลจาก primaltennis.com / betweenthelinesbkk.com / tennisbangkok.com / asiafirms.com / เว็บสนามโดยตรง; GPS verified (12 หมุดถูกแก้ไข: ids 1,6,8,11,12,14,20,22,25,26,27,29)
- **สนาม Pickleball:** 20 สนามในกรุงเทพฯ (ids 101–120) — GPS verified รอบ 2 (แก้ไข: 101,102,103,108,111,114,115); id:120 เปลี่ยนจากสนามปลอม → Slowcombo (จุฬา); 3 สนามยังต้องตรวจสอบ (110, 118, 119)
- **Rating/Reviews:** Google Maps rating — ตอนนี้ใส่ค่าประมาณไว้ก่อน รอเจ้าของ project มา verify และอัพเดตทีหลัง
- **googleMaps field:** มีแล้วใน courts บางสนาม (ids 1, 14, 28, 101, 115) — ใช้สำหรับ redirect ตรงจาก detail modal
- **website field:** มีแล้ว 26 สนาม — Tennis: ids 1, 2, 6, 7, 8, 9, 12, 16, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28 (18 สนาม) | Pickleball: ids 101, 102, 106, 107, 108, 109, 110, 115 (8 สนาม) — สนามที่เหลือใช้แค่ Facebook/Instagram
- **รูปภาพ:** ระบบพร้อมแล้ว — `image:` field ใน COURTS, fallback อัตโนมัติเป็น gradient+SVG ถ้าไม่ใส่หรือโหลดไม่ได้ (onError); ตอนนี้มีรูปแล้ว 1 สนาม (id:1 CozyTennis)
- **ระบบจอง:** ไม่มี ใช้ช่องทางติดต่อ (โทรศัพท์ / Google Maps) แทน

## สนามที่ต้องตรวจสอบเพิ่มเติม

### Tennis
- **id:29 Grand Tennis Club** — GPS 13.7997/100.377 อาจไกลตะวันตกเกินไป รอ verify
- **id:30 คอร์ตรามาเก้า** — district ห้วยขวาง อาจเป็น Prawet จริงๆ รอ verify

### Pickleball
- **id:110 Arise Pickleball** (ห้วยขวาง) — อาจไม่มีสนามประจำที่ รอ verify
- **id:118 Windfield Pickleball** — อาจเป็นสนามเทนนิสอย่างเดียว ไม่มี pickleball รอ verify
- **id:119 Lat Phrao Pickleball Arena** — ไม่พบหลักฐานว่ามีอยู่จริง ต้องหาข้อมูลทดแทน

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

## Features (Design v2 — implemented)

- **Sport tabs:** Tennis / Pickleball — อยู่เหนือ filter bar (ไม่ใช่ standalone bar), มีทั้งในหน้า list และ map
- **Layout:** Merged home + list view (single-page scroll ไม่มี Home tab แยก)
- **Inline filter bar:** Sticky bar ใต้ hero — type pills, text toggles (ในร่ม, มีแอร์, ไฟกลางคืน, ใกล้ BTS), sort select (ไม่มี zone pills); **bilingual** — pills/labels เปลี่ยนตาม `lang` state
- **Sort options:** ★ คะแนน / ฿ ราคา / 🎾 คอร์ด / ก–ฮ ตัวอักษร (Thai) / A–Z ตัวอักษร (English)
- **aircon field:** boolean ใน COURTS data — confirmed: Sterling Court (tennis), Asoke Pickleball (pickleball)
- **Map view:** Leaflet + OpenStreetMap, custom pin markers, sidebar list, popup; sport tabs ใน map header; markers update reactive ตาม sport (split useEffect + markersRef pattern)
- **Detail modal:** ข้อมูลติดต่อ, facilities, ราคา, เวลา, Google Maps link
- **Free court display:** `priceMin===0` → แสดง "ฟรี" ในทุก context (card, modal, map popup, sidebar)
- **Themes:** dark / light / bold via CSS vars (oklch color palette)
- **Language:** ไทย / EN toggle — pill buttons ใน nav bar (ขวาบน) + ใน tweaks panel (sync กัน, share `lang` state เดียว)
- **Tweaks panel:** Floating draggable panel (theme, lang, show-featured-only)
- **Website button:** ปุ่ม 🌐 ใน detail modal — แสดงเมื่อ `court.website` มี (ระหว่างปุ่มโทรศัพท์กับ Google Maps); สีส้ม-น้ำตาล แยกจากปุ่มอื่น
- **Pickleball icon:** Custom SVG — ไม้สีดำ (เหลี่ยม), ลูกสีส้ม (ไม่ใช่ emoji)
- **CourtSVG:** Landscape orientation — net เป็นเส้นตั้ง, service lines เป็นเส้นตั้ง, center service line เป็นเส้นนอน

## สิ่งที่วางแผนจะทำ

- [ ] เพิ่มรูปภาพสนามที่เหลือ — มี id:1 แล้ว, ที่เหลือ 46 สนาม (ดู Workflow ด้านล่าง)
- [x] ระบบรูปภาพ — `image:` field + fallback (CourtCard + Modal)
- [x] เพิ่ม website field + ปุ่ม 🌐 ใน modal — 26 สนามมีแล้ว (Tennis 18, Pickleball 8)
- [x] ปุ่ม TH/EN ใน nav bar + bilingual filter bar (type pills, text toggles, sort, reset)
- [x] Git + GitHub Pages — auto-deploy on push
- [ ] อัพเดต rating/reviews + googleMaps link ทุกสนาม — ส่ง format นี้ให้ Claude: `id:X ชื่อ → https://maps.app.goo.gl/xxx (rating: 4.x, NNN reviews)`
- [ ] Verify aircon สนามที่ยังไม่แน่ใจ (Beat Discovery, Club 46, Suk Space, Arise, Windfield Tennis, CV Sport)
- [ ] Verify / แก้ไข ids 110, 118, 119 (pickleball) — ดูส่วน "สนามที่ต้องตรวจสอบ" ด้านบน
- [ ] Verify ids 29, 30 (tennis GPS/district) — ดูส่วน "สนามที่ต้องตรวจสอบ" ด้านบน
- [x] Verify และเพิ่มข้อมูล Pickleball courts (20 สนาม, ids 101–120)
- [x] GPS verify รอบ 2 — แก้ pickleball 7 หมุด, เปลี่ยน id:120 เป็น Slowcombo
- [x] Filter bar redesign — เอา zone pills ออก, เพิ่ม aircon/indoor เป็น text pills
- [x] Sport tabs ย้ายลงมาอยู่เหนือ filter bar
- [x] Map view — sport tabs + reactive markers เมื่อเปลี่ยน sport
- [x] GPS verify + แก้ไข 12 หมุดผิด + ลบ 3 duplicate courts (tennis)
- [x] Sort ตัวอักษร — ก–ฮ (Thai) และ A–Z (English)
- [x] googleMaps field — ถ้ามี link จะ redirect ตรง, ถ้าไม่มี fallback เป็น search by name+address

## โครงสร้าง COURTS data

### Tennis (TENNIS_COURTS — ids 1-30)
```js
{
  id, name, nameTh, district, districtEn, zone,
  address, type,        // "hard" | "clay" | "grass"
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
  image,                // string | undefined — path เช่น "images/court-1.jpg"
                        //   ถ้ามี + โหลดได้ → แสดงรูป (cover) | ถ้าไม่มี/404 → fallback gradient+CourtSVG
  website,              // string | undefined — URL เว็บไซต์ของสนาม เช่น "https://www.cozytennis.com/"
                        //   ถ้ามี → แสดงปุ่ม 🌐 เว็บไซต์ ใน detail modal (ระหว่างปุ่มโทรศัพท์กับ Google Maps)
}
```

### Pickleball (PICKLEBALL_COURTS — ids 101-120)
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
| 120 | **Slowcombo** (เปลี่ยนจากสนามปลอม) | 126 ซ.จุฬาลงกรณ์ 50 วังใหม่ ปทุมวัน, 2 outdoor courts, ฟรี (ซื้อเครื่องดื่ม), 080-914-4565, 10:00-20:00 |

## Zones ที่ใช้

`ใจกลางกรุง` / `สุขุมวิท` / `ฝั่งตะวันออก` / `ฝั่งเหนือ` / `ริมแม่น้ำ` / `ฝั่งใต้` / `ฝั่งตะวันตก`

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
