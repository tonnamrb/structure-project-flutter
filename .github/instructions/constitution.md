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
     3. Constitution (กติกานี้)
