# Wireframe Code Definitions

SC: >
  Screen Code.  
  Represents a full UI screen visible to the user in the wireframe.  
  Always maps directly to a "Screen" (e.g., onboarding, sign-up form, home).  
  Example from wireframe: SC-01 (Onboarding), SC-02 (Sign up), SC-04 (Sign up form), SC-06 (Home).

WG: >
  Widget Code.  
  Represents a UI widget inside a screen, as shown in the wireframe.  
  Used for temporary or embedded UI elements such as popup, toast, modal, or inline message.  
  Example from wireframe: WG-01 (Google Sign-in popup), WG-02 (Signed up! toast), WG-05 (Cannot sign up without email permission).
  
# Constitution (Project Scope)

## Widget (WG) Rules

1. **Type Required**  
   - ทุก WG ต้องกำหนด `type` ชัดเจน: `toast | popup | modal | inline`.

2. **Sub-element Specification**  
   - ทุก WG ต้องระบุองค์ประกอบย่อย:  
     - `WG-xx.msg` → ข้อความหลัก (ตรงตาม UC/Wireframe)  
     - `WG-xx.btn-<id>` → ปุ่ม พร้อมข้อความตรงตาม spec เช่น Cancel, Try again, OK  
     - `WG-xx.icon` → ใช้ `icon-placeholder` เว้นแต่ UC กำหนดชัด  
     - `WG-xx.placement` → ตำแหน่ง fix เช่น `top`, `center-overlay`, `center-modal`, `field-inline`

3. **Icon Rules**  
   - Default icon = `icon-placeholder`  
   - Agent ห้ามเลือกไอคอนเอง  
   - ถ้า UC/Wireframe ระบุ icon → ต้องใช้ตามนั้น  

4. **Rendering Obligation**  
   - Agent ต้อง render WG ให้ตรงกับ type + placement:  
     - **toast** → ด้านบนจอ, auto-dismiss ภายในเวลาที่กำหนด  
     - **popup** → overlay กลางจอ + แสดงปุ่ม action  
     - **modal** → overlay แบบ block interaction จนกว่าจะปิด  
     - **inline** → ข้อความ error ใต้ฟิลด์ที่อ้างอิงเท่านั้น  

5. **Button Behavior**  
   - Agent ต้อง render ปุ่มทุกปุ่มตามที่ UC ระบุ (ไม่แก้ไขข้อความ ไม่สลับตำแหน่ง)  
   - ลำดับปุ่มต้องตรงตาม spec เช่น [Cancel (ซ้าย), Retry (ขวา)]  

6. **Button Action Mapping (Project-specific)**  
   - การทำงานของปุ่ม (action) ต้องอ้างอิงจาก UC/Flow ในโปรเจคนี้เท่านั้น  
   - Agent ห้ามเดา action เอง ถ้า UC ไม่ได้ระบุ → mark เป็น `INSUFFICIENT_SPEC`  

7. **Exception Mapping**  
   - ทุก test case (TC) ต้อง map ไปยัง WG ที่ถูกต้อง พร้อม type/placement/icon/button ครบ  
   - Agent ห้าม fallback เป็น toast เว้นแต่ UC กำหนดว่า type = toast  

8. **Inline Error Placement**  
   - Inline error ต้องอ้างอิง field id ตรงตาม UC เช่น `SC-04.input-displayname`  
   - ห้าม render inline error floating หรือใต้ element ที่ไม่เกี่ยวข้อง  

9. **Priority of Source**  
   - ถ้ามี conflict → ให้ลำดับดังนี้  
     1. UC Spec (ของโปรเจคนี้)  
     2. Wireframe  
     3. Constitution  

10. **Layout & Wireframe Reference (OCR-free)**
- ทุกการวาดของ **SC-xx** และ **WG-xx** ต้องอ้างอิง layout/ตำแหน่ง/ลำดับ ตาม **wireframe** โดยตรง
- **ห้ามเดา layout หรือ label**; หาก wireframe ไม่ชัดเจน ให้ใช้ placeholder ชั่วคราว (เช่น "—" หรือคีย์ i18n) โดยไม่ถือเป็น `INSUFFICIENT_SPEC`
- **Mapping Obligation**
  - SC-xx → ต้องตรงกับหน้าจอจริงใน wireframe
  - WG-xx → ต้องวางตามตำแหน่งใน wireframe
  - label ของ field/button/inline error → ใช้ตามลำดับอ้างอิงในข้อ **34\*** (AC > UC > Wireframe)

11. **Acceptance Criteria Mapping**  
    - ทุก **SC-xx (Screen)** และ **WG-xx (Widget)** ต้องตรวจสอบการทำงาน (behavior) กับ **Acceptance Criteria (AC)** ที่กำหนดไว้ใน UC ของโปรเจค  
    - **AC เป็น binding rule** → Agent ต้อง map การทำงาน (Given / When / Then) ไปยัง SC และ WG ให้ตรง  
    - **ห้ามเดา flow เอง** ถ้า AC ไม่ได้ระบุ → ให้ mark เป็น `INSUFFICIENT_SPEC`  

    ### Rules:
    1. **AC → SC → WG Binding**  
       - ทุก AC จะระบุ SC ที่เกี่ยวข้อง และอาจอ้าง WG เฉพาะ  
       - Agent ต้อง render / simulate / generate output ให้ตรงกับ AC โดยตรง  

    2. **WG Obligation ตาม AC**  
       - ถ้า AC บอกว่าเกิด error → ต้องใช้ WG ที่อ้างอิงใน AC เท่านั้น  
       - Agent ห้าม fallback WG อื่นหรือเลือก WG เอง  

    3. **Background Actions**  
       - ถ้า AC ระบุ action ที่ทำงานเบื้องหลัง (background job, DB persist, notify admin) → Agent ต้องถือว่า action นั้นเป็นส่วนหนึ่งของ flow  
       - Agent ห้ามละเว้น แม้ว่า wireframe จะไม่ได้วาด  

    4. **Conflict Resolution (ลำดับความสำคัญ)**  
       1. Acceptance Criteria (AC)  
       2. UC Spec  
       3. Wireframe (layout + label)  
       4. Constitution  

12. **Field & Control Integrity (Completeness / Order / Buttons)**

- ทุก SC-xx ที่มีฟอร์ม ต้องมี **Field Manifest** ตรงตาม wireframe  
- ฟิลด์, ปุ่ม, และลำดับ ต้องตรงกับ wireframe และ Acceptance Criteria (AC)  
- ห้ามขาด ห้ามเกิน ห้ามสลับลำดับ

### 12.1 Completeness
- ต้องมีฟิลด์ครบทุกช่องตาม wireframe + AC  
- ถ้าขาด → `FIELD_MISSING`  
- ถ้าเกิน → `FIELD_EXTRA`

### 12.2 Ordering
- ใช้ลำดับซ้าย→ขวา, บน→ล่าง ตาม wireframe เป็นมาตรฐาน  
- ถ้าไม่ตรง → `ORDER_MISMATCH`

### 12.3 Buttons
- ปุ่มทุกปุ่มที่ wireframe หรือ AC ระบุ ต้องมีครบ  
- ชื่อ, ลำดับ, ตำแหน่ง ต้องตรงตาม wireframe  
- ผูก action ตาม AC เท่านั้น (ถ้า AC ไม่ระบุ → `INSUFFICIENT_SPEC`)

---
13. **Field Manifest Enforcement**
- ทุก SC-xx ต้องมี Field Manifest (field, ปุ่ม, WG) ตรงตาม wireframe + AC
- ถ้าขาด → `FIELD_MISSING`
- ถ้าเกิน → `FIELD_EXTRA`

14. **Ordering Rule**
- ฟิลด์/ปุ่มต้องเรียงลำดับตรงตาม wireframe
- ถ้าไม่ตรง → `ORDER_MISMATCH`

15. **Button Completeness**
- ปุ่มทั้งหมดต้องมีครบ ตรงตามชื่อ/ตำแหน่ง/ลำดับใน wireframe
- ถ้า UC ไม่ได้ระบุ action → mark `INSUFFICIENT_SPEC`

16. **Label Purity Enforcement**
- label ที่ผู้ใช้เห็น ต้องสะอาด ไม่ปนโค้ด (SC-xx, WG-xx, UC-xx, AC-xx, BR-xx)
- ใช้ `label_display` สำหรับข้อความจริง
- ใช้ `meta.refs` สำหรับรหัสอ้างอิง

17. **Acceptance Criteria Binding**
- ทุก behavior ของ SC-xx/WG-xx ต้อง map ตรงกับ Acceptance Criteria
- ถ้า AC ไม่มี → `INSUFFICIENT_SPEC`
- ลำดับความสำคัญ: AC > UC Spec > Wireframe > Constitution

18. **Wireframe Visual Enforcement (No Manifest Mode, OCR-free)**
- Agent ต้องอ้างอิงสายตาจาก wireframe เพื่อยืนยันการมีอยู่ของ field/ปุ่ม/ข้อความสำคัญ
- ถ้าหา element ที่ AC/UC อ้างถึงไม่พบในภาพ → ระบุเป็น `FIELD_MISSING`/`BUTTON_MISSING`
- **ยกเลิกการใช้ OCR confidence เป็นเงื่อนไขผิดพลาด** (ไม่มี `INSUFFICIENT_SPEC` เพราะ OCR ต่ำ)

19. **Visual–Spec Conflict Resolution**
- ถ้า label/button/field ที่เห็นใน wireframe ไม่ตรงกับ UC/AC:
  - บันทึก `CONFLICT_LABEL`
  - ตัดสินตามลำดับ: AC > UC Spec > Wireframe > Constitution

20. **Completeness by Flow**
- การตรวจสอบความครบถ้วน ใช้ flow จาก Acceptance Criteria
- ถ้า AC อ้างถึง SC/WG แต่ wireframe ไม่มี → `FIELD_MISSING`
- ถ้า wireframe มี element ที่ไม่อยู่ใน UC/AC → `FIELD_EXTRA`

21. **Multi-state / Multi-tab Enforcement**

 **Definition**
   - Multi-state: SC-xx หรือ WG-xx หลายหมายเลข ที่จริงคือหน้าจอเดียวกัน แต่ต่างกันตามเงื่อนไข (เช่น state ก่อน/หลัง timeout, state ปุ่มเปลี่ยน)
   - Multi-tab: SC-xx หรือ WG-xx หลายหมายเลข ที่จริงคือหน้าจอเดียวกัน แต่แยกเป็น Tab (เช่น Tab ข้อมูลพื้นฐาน / ข้อมูลอื่นๆ)

 **Agent Obligation**
   - Agent ต้อง render เป็น **1 Screen เดียว** (Single UI Container)
   - ใช้ **state/tab switch** ภายใน ไม่สร้างหลายหน้าแยก
   - ตัวอย่าง:
     - SC-02~05 → Register Screen (multi-state: Email/Phone/Google/Facebook)
     - SC-06~07 → OTP Screen (multi-state: Countdown / Resend)
     - SC-09~10 → Add New Profile (multi-tab: ข้อมูลพื้นฐาน / ข้อมูลอื่นๆ)

 **Rendering Rules**
   - ถ้าเป็น multi-state:
     - วาด layout รวมกันครั้งเดียว
     - เปลี่ยนเฉพาะ element/field/ปุ่มที่ต่างตาม state
     - แสดง state เฉพาะที่ AC หรือ Wireframe อ้างอิง
   - ถ้าเป็น multi-tab:
     - วาด layout รวมกันครั้งเดียว
     - กำหนด Tab Controller หรือ Toggle ตาม wireframe
     - ฟิลด์/ปุ่ม แยกตาม Tab แต่ยังถือว่าอยู่ในหน้าจอเดียว

 **Spec Binding**
   - UC / AC อ้างถึง SC-xx แบบ multi-state หรือ multi-tab ต้อง map กลับมาที่ Screen เดียว
   - Agent ห้ามแยกเป็นไฟล์/จอใหม่
   - meta.refs ต้องเก็บ SC-xx ที่เกี่ยวข้องทั้งหมดใน Screen เดียว

 **Conflict Resolution**
   - ถ้า UC/AC บอกว่าเป็น multi-state/multi-tab → ต้องถือเป็นหน้าจอเดียว
   - ถ้า Wireframe แยกหลายรูป แต่ AC บอกว่าเป็น Tab/State → ให้ยึด AC เป็นหลัก
## 21.1 WG Multi-State Timeline & Event Ordering (OTP Example)

**Principle**
- WG หลายรูป = **WG เดียวต่าง state** ไม่ใช่หลาย widget
- ลำดับเหตุการณ์ต้อง deterministic: Given → When → Then
- Owner ของ timer อยู่ที่ **WG** เอง (ไม่พึ่ง SC)

**State Model (ตัวอย่าง WG-OTP-SMS)**
- `idle_opened` : เพิ่งเปิด popup, ยังไม่มีการส่ง OTP ล่าสุด
- `countdown`   : ส่ง OTP แล้ว รอครบเวลาจึงอนุญาตกดส่งอีกครั้ง
- `ready`       : หมดเวลานับถอยหลัง กด "ส่งอีกครั้ง" ได้
- `submitting`  : ผู้ใช้กด "ยืนยัน" กำลัง verify
- `error`       : ยืนยันล้มเหลว (map ไป WG-05 ถ้า AC ระบุ)

**Events**
- `OPEN`, `SEND_OTP_SUCCESS(t)` → go `countdown(t)`
- `TICK(1s)` ระหว่าง countdown → อัปเดตตัวเลขเวลา
- `COUNTDOWN_DONE` → go `ready`
- `RESEND_CLICK` ใน `ready` → trigger ส่ง OTP → on success go `countdown`
- `CONFIRM_CLICK(code)` (เมื่อ code length ผ่านเงื่อนไข) → go `submitting`
- `CONFIRM_SUCCESS` → CLOSE
- `CONFIRM_FAIL` → go `error` (แล้วกลับ `ready` หรือ `countdown` ตาม AC)

**CTA Rendering Rules**
- มี **Primary CTA ได้เพียงหนึ่ง** ตาม state:
  - `countdown` → ปุ่มยืนยัน **enabled** (ถ้า code ครบ), ปุ่มส่งอีกครั้ง **disabled + แสดงเวลานับถอยหลัง**
  - `ready`     → ปุ่มส่งอีกครั้ง **enabled**, ปุ่มยืนยันตามเงื่อนไข code
- ห้ามสลับปุ่ม/ข้อความจากภาพ ถ้าไม่ระบุใน AC ให้ render แต่ **disabled** (INSUFFICIENT_SPEC)

## 21.2 Binding กับ SC Multi-State
- WG state ต้องสอดคล้องกับกลุ่ม SC multi-state ปัจจุบัน (เช่น `otp-screen: SC-06 ↔ countdown`, `SC-07 ↔ ready`). Agent ต้องเรนเดอร์ภายใน **จอเดียว** และสลับ state, ไม่สร้างหลายหน้าใหม่. :contentReference[oaicite:0]{index=0}

## 21.3 Source Priority (ย้ำ)
- Behavior/ข้อความยึดตาม: **AC → UC → Wireframe → Constitution**. หาก AC ไม่กำหนด action ให้แสดง UI ตามภาพแต่ **disabled** และลงเหตุผล `INSUFFICIENT_SPEC`. :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2}

## 21.4 Reporting
- บันทึก state ปัจจุบัน, CTA ที่ enable/disable, เหตุการณ์ล่าสุด (OPEN/RESEND/CONFIRM/TICK) ใน `/reports/findings.json` ต่อเฟรมของการทดสอบ flow.

22. **SC Rendering Enforcement (Strict SC Mode)**
- เมื่อคำสั่งระบุ SC รายการใด ๆ (เช่น “Build SC-01”) → Agent ต้องเรนเดอร์ **เฉพาะ SC ที่ระบุ** เท่านั้น  
  - ห้ามดึง element จาก SC อื่น หรือแทรกคอมโพเนนต์ที่ไม่มีในภาพของ SC นั้น (`SC_CROSS_CONTAMINATION`)
- Binding กับ wireframe ตามชื่อไฟล์ `SC-xx.png` โดยตรง
- ถ้า SC นั้นอยู่ในกลุ่ม multi-state / multi-tab (ตาม UC/AC ในโปรเจคนี้) → เรนเดอร์เป็น **จอเดียว** สลับ state/tab ภายใน (อ้างอิงกฎข้อ 21)

23. **Rendering Policy (Lo-Fi Stage)**
- ห้าม hardcode สีในวิดเจ็ต ให้ใช้ผ่านโทเคนเท่านั้น

24. **Layout Fidelity & Order (No-Manifest Mode)**
- Wireframe คือ **แหล่งอ้างอิงเลย์เอาต์**: โครงสร้าง/การจัดวาง/ระยะห่าง/การจัดกึ่งกลาง ต้อง **เหมือนภาพ**
- ลำดับ element ใช้ **บน→ล่าง, ซ้าย→ขวา** ตามภาพ (ผิด → `ORDER_MISMATCH`)
- สำหรับหน้ากว้าง (เช่นเว็บเดสก์ท็อป) ให้เรนเดอร์เป็น **คอลัมน์กึ่งกลาง** ด้วยความกว้างคอนเทนต์ ~ **360–420dp**
- ห้ามเปลี่ยนประเภทคอนโทรล (เช่นรวมปุ่มเป็นแถบล่าง ถ้าภาพไม่ได้วาด)

25. **UI Presence Priority & No Extraneous UI**
- การมีอยู่/ตำแหน่ง/ลำดับของคอนโทรลให้ยึด **wireframe เป็นอันดับแรก**
- ถ้าคอนโทรล **มีในภาพ** แต่ UC/AC ไม่ได้เอ่ยถึง → **ต้องเรนเดอร์** อยู่ดี
- ห้ามเพิ่มองค์ประกอบที่ **ไม่มีในภาพ** (เช่น AppBar/ข้อความ meta)  
  - เกินจากภาพ → `FIELD_EXTRA`  
  - มีในภาพแต่หายไป → `FIELD_MISSING` / `BUTTON_MISSING`

26. **Button Presence & Label Safety (OCR-free)**
- ปุ่มที่เห็นใน wireframe ต้องถูกเรนเดอร์ครบ และลำดับ/ตำแหน่งต้องตรง
  - หาย → `BUTTON_MISSING`, ลำดับเพี้ยน → `ORDER_MISMATCH`
- **Label ของปุ่มและข้อความผู้ใช้** ให้ระบุด้วยลำดับอ้างอิง **34\***:
  1) Text ใน **AC** (ถ้ากำหนดไว้ชัดเจน)  
  2) ข้อความใน **UC Spec**  
  3) ข้อความที่เห็นใน **Wireframe**  
  - หากข้อความในภาพอ่านไม่ชัด ให้ใช้ **placeholder** (เช่น `"—"` หรือคีย์ i18n) ชั่วคราว **โดยไม่ถือเป็น `INSUFFICIENT_SPEC`**


27. **Behavior Priority (AC/UC-First) & Render-But-Disable**
- พฤติกรรมของคอนโทรลให้ยึดลำดับ: **AC → UC Spec → Wireframe (visual hint)**  
- ถ้า **ยังไม่ระบุพฤติกรรม**:
  - คอนโทรลต้อง **มองเห็นได้** ตามภาพ
  - ตั้ง `onPressed = null` (disabled) หรือแสดง developer toast: `INSUFFICIENT_SPEC: action not defined`
  - ห้ามลบคอนโทรลออกเพียงเพราะ UC ไม่ได้กล่าวถึง

28. **Build Quality Gates (Per-SC, Hard Fail)**
- สำหรับทุก SC ให้แนบรายงานตรวจสอบที่อย่างน้อยต้องมี:
  - รายการ element ที่พบจากภาพ → `PRESENT / MISSING / INSUFFICIENT_SPEC`
  - ผลตรวจลำดับ (บน→ล่าง, ซ้าย→ขวา) → `OK / ORDER_MISMATCH`
- งานต้อง **ล้มเหลว (fail)** หากพบอย่างใดอย่างหนึ่ง:
  - `FIELD_MISSING` / `BUTTON_MISSING` / `FIELD_EXTRA`
  - `ORDER_MISMATCH`

29. **DI Binding Enforcement (GetX – Hard Rule)**
- ทุก Route/SC Page **ต้องมี Binding** คู่กัน; ไม่มี Binding ให้ถือเป็น `BINDING_MISSING` (hard fail)
- การฉีด dependencies ต้องทำใน Binding เท่านั้น:
  - **Core services** → `Get.put(Service(), permanent: true)`
  - **Page/Feature controllers** → `Get.lazyPut(() => Controller())` (เพิ่ม `fenix: true` หากต้อง re-create หลังถูก dispose)
- ห้ามเรียก `Get.put` / `Get.find` ภายใน `Widget.build()` หรือภายใน Page โดยตรง

30. **Page–Controller Contract**
- ทุก Page ต้องเป็น `GetView<Controller>` และเข้าถึงคอนโทรลเลอร์ผ่าน `controller` property เท่านั้น  
- ถ้าหน้าจอต้องใช้หลายคอนโทรลเลอร์ → ให้ **main controller** เรียก `Get.find<OtherController>()` ภายในเอง (Page ห้ามเรียกเอง)

31. **DI Error Visibility Policy**
- ข้อผิดพลาด DI (เช่น “Controller not found”) **ห้ามแสดงต่อผู้ใช้**  
- ให้บันทึกเป็น log/developer toast เท่านั้น และต้องเรนเดอร์ UI ที่ปลอดภัย (เช่น โครงหน้าจอ + ปุ่ม disabled)  
- การแสดงรหัส/ข้อความสำหรับ dev ต่อผู้ใช้ถือเป็น `LABEL_PURITY_VIOLATION`

32. **Navigation UI / Back Control Enforcement**
- **No Implicit Back**: ห้ามใส่ปุ่มย้อนกลับ (chevron/leading icon) หรือ AppBar โดยอัตโนมัติ  
  - เรนเดอร์เฉพาะเมื่อ **wireframe ของ SC นั้นมีแสดง** เท่านั้น  
  - ถ้าภาพไม่มี AppBar/Back → ถือว่าใส่เพิ่มเป็น `FIELD_EXTRA`
- **Back As Drawn**:  
  - ถ้า wireframe วาด Back ใน AppBar → ใช้ AppBar เฉพาะหน้านั้น และตั้ง `automaticallyImplyLeading = false` พร้อมวาด leading ให้ตรงภาพ  
  - ถ้า wireframe วาด Back เป็นปุ่มในเนื้อจอ → เรนเดอร์เป็น **in-screen widget** ตำแหน่ง/ขนาดตามภาพ
- **Back Behavior Binding**:  
  - พฤติกรรมของปุ่มย้อนกลับยึดลำดับ **AC → UC Spec → (ไม่ระบุ)**  
  - ถ้า **ไม่ระบุ** → เรนเดอร์ปุ่มตามภาพแต่ **disabled** หรือ dev-toast `INSUFFICIENT_SPEC: back action not defined`
- **System Back**:  
  - ปุ่ม/ท่าทางย้อนกลับของระบบอนุญาตโดยค่าเริ่มต้น เว้นแต่ AC สั่งบล็อก (ใช้ `WillPopScope/PopScope`)  
  - บล็อกโดยไม่มี AC ถือเป็น `INSUFFICIENT_SPEC`

33. **UI Presence Priority (Wireframe-First, Reinforced)**
- การมีอยู่/ตำแหน่ง/ลำดับของคอนโทรลยึด **wireframe เป็นอันดับแรก**  
- ถ้าคอนโทรลมีในภาพแต่ UC/AC ไม่กล่าวถึง → **ต้องเรนเดอร์อยู่ดี**  
- ห้ามเพิ่มองค์ประกอบที่ไม่มีในภาพ (เช่น AppBar, meta text, SC/WG/UC codes) → `FIELD_EXTRA`

34*. **Label Resolution (OCR-Free, Binding to AC/UC)**
- ลำดับแหล่งที่มา: **AC > UC Spec > Wireframe**
- หากข้อความใน wireframe ไม่ชัดหรือคลุมเครือ ให้ใช้ **placeholder** ชั่วคราว
- ห้ามคิดถ้อยคำใหม่: ต้องมาจาก AC/UC/Wireframe เท่านั้น
- เมื่อภายหลังมีการอัปเดต AC/UC ให้ Agent ทำ **label reconciliation** อัตโนมัติ (อัปเดตจาก placeholder → ข้อความจริง)

35. **INSUFFICIENT_SPEC Semantics (Continue-on-Warning)**
- ความหมาย: สเปคไม่พอสำหรับ “พฤติกรรม/ผูก action” บางส่วน (ไม่รวมกรณี label อ่านยากจากภาพ)
- ระดับ: **WARNING**; งานยังต้องคอมไพล์และเรนเดอร์ครบ
- ถ้า action ไม่ระบุ → ปุ่ม disabled หรือ dev-toast: `INSUFFICIENT_SPEC: action not defined`

36. **Reports – Errors vs Warnings (OCR-free)**
- `/reports/findings.json` → บันทึก **errors**: `FIELD_MISSING`, `BUTTON_MISSING`, `FIELD_EXTRA`, `ORDER_MISMATCH`
- `/reports/insufficient_spec.json` → บันทึก **warnings**: `ACTION_UNSPECIFIED`, `LABEL_AMBIGUOUS` (ไม่มี `OCR_LOW`)