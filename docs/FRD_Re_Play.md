# **Functional Requirements Document : Re:Play**

เอกสารนี้สรุป “สิ่งที่ระบบต้องทำ” (WHAT) อย่างละเอียด แยกย่อยเป็นฟังก์ชัน, business rules, เงื่อนไข, เคสขอบ และเกณฑ์ยอมรับ เพื่อใช้ส่งต่อ Dev/QA/Design โดยทีม Design จะวาด wireframe อ้างอิงจาก Use Cases ในเอกสารนี้โดยตรง

**Project:** Re:Play  
**Phase 1 (MVP)**  
**Reference:** PRD V0.01 (2025‑09‑10)  
**Version:** 0.01  (2025‑09‑16)

## **1 Roles & Permissions (WHAT)**

* **Visitor** → สมัคร/เข้าสู่ระบบด้วย Google  
* **Member** → ฟังอัลบั้มย้อนหลัง, ใช้ฟิลเตอร์, Save/Unsave Albums, จัดการโปรไฟล์  
* **Admin** → สร้าง/แก้ไข/ลบ ศิลปิน และอัลบั้มทางการ

## **2 System Use Cases with Embedded Test Scenarios**

### **UC-01 Sign up with Google** 

**Actors:** Visitor, Google (SSO Provider)

**Description:** ผู้ใช้ใหม่ต้องการสมัครเข้าใช้งานโดยใช้บัญชี Google เพื่อลดความซับซ้อนในการลงทะเบียน ระบบต้องรองรับการยืนยันตัวตนผ่าน Google OAuth และสร้างบัญชีใหม่ให้ผู้ใช้พร้อมบังคับให้ยอมรับ PDPA ก่อนเริ่มใช้งาน

**Precondition:** 

* ผู้ใช้ยังไม่มีบัญชีในระบบ

* แอปตั้งค่า Google OAuth (client\_id, redirect\_uri, scope=email, profile) เรียบร้อยแล้ว

**Trigger:** ผู้ใช้กด "Continue with Google"

**Main Flow:**

1. ผู้ใช้เลือก "Sign up with Google"

2. Redirect ไป Google → ผู้ใช้ยืนยันตัวตน (scope: email, profile)

3. Google ส่ง token กลับ

4. ระบบตรวจสอบ token → ดึงอีเมล/โปรไฟล์

5. หากยังไม่มีบัญชี → สร้างบัญชีใหม่/ผูก provider\_id → สร้างเซสชัน

6. กรอกข้อมูลเพิ่มเติม  
   * Displayname (Required)  
     * ห้ามซ้ำกับ Displayname ของ member  ในระบบ  
     * กรอกได้ไม่เกิน 30 ตัวอักษร ไม่ให้พิมพ์เกิน / ตัดอัตโนมัติ  
     * ห้ามใส่อักขระพิเศษและ emoji  
   * Date of birth (Required)  
     * เป็น Calendar ให้เลือกวันเดือนปี  
     * Default วันที่ปัจจุบัน  
     * Calendar กันไว้ไม่ให้เลือกวันในอนาคต  
   * Gender (Required)  
     * Female  
     * Male  
     * Other

7. อ่านและยอมรับ ToS/PDPA → ยอมรับ PDPA → Home 

8. กด “Continue”

9. ระบบแสดง “Signed up\!” และอยู่หน้า  Home 

**Alternative / Exception Flows:**

**Test Case ID:** TC01-1  
**Use Case (รหัส):** UC-01  
**Scenario:** Cancel บนหน้า Google SSO  
**Preconditions:** เริ่ม flow สมัครด้วย Google  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. กด “Continue with Google”  
2. กดยกเลิกบนหน้า Google

**Expected Result:** Redirect กลับหน้า Login Toast: “Sign up canceled.” (ไม่มีปุ่ม)  
**Test Data:** –  
**Priority:** Medium

---

**Test Case ID:** TC01-2  
**Use Case (รหัส):** UC-01  
**Scenario:** Token invalid/expired  
**Preconditions:** จำลอง token หมดอายุ  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google  
2. รับ token invalid

**Expected Result:** Toast: “Authentication failed. Please try again.” / ปุ่ม Retry  
**Test Data:** Token=invalid  
**Priority:** High

---

**Test Case ID:** TC01-3  
**Use Case (รหัส):** UC-01  
**Scenario:** Duplicate email → treat as login  
**Preconditions:** อีเมลนี้มีบัญชีอยู่แล้ว  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google ด้วยอีเมลเดิม

**Expected Result:** ระบบ Treat เป็น Login → Redirect หน้า Home (ไม่มีข้อความแจ้งเตือน)  
**Test Data:** Email=existing@replay.test  
**Priority:** Medium

---

**Test Case ID:** TC01-4  
**Use Case (รหัส):** UC-01  
**Scenario:** Email scope missing  
**Preconditions:** ผู้ใช้ปิด scope email  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google  
2. ไม่ส่ง email กลับมา

**Expected Result:** Dialog: “Cannot sign up without email permission.” / ปุ่ม Cancel, Try again  
**Test Data:** –  
**Priority:** High

---

**Test Case ID:** TC01-5  
**Use Case (รหัส):** UC-01  
**Scenario:** Replay token reuse  
**Preconditions:** ใช้ token เดิมซ้ำ  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google ได้ token  
2. ส่ง token เดิมซ้ำ

**Expected Result:** Toast: “Invalid request. Please try again.” (ไม่มีปุ่ม) และบันทึก log  
**Test Data:** Token=reused  
**Priority:** High

---

**Test Case ID:** TC01-6  
**Use Case (รหัส):** UC-01  
**Scenario:** Missing required fields  
**Preconditions:** หน้า Sign up  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. เว้น Displayname/DOB/Gender  
2. กด Continue

**Expected Result:** Inline validation: “Please fill in all required fields.”; ไม่อนุญาตให้สมัคร  
**Test Data:** Displayname=“”, DOB=“”, Gender=“”  
**Priority:** High

---

**Test Case ID:** TC01-7  
**Use Case (รหัส):** UC-01  
**Scenario:** Duplicate displayname  
**Preconditions:** Displayname ซ้ำกับสมาชิกอื่น  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. กรอก Displayname ที่มีอยู่แล้ว  
2. กด Continue

**Expected Result:** Toast: “Displayname already taken.” (ไม่มีปุ่ม)  
**Test Data:** Displayname=existing\_name  
**Priority:** Medium

---

**Test Case ID:** TC01-8  
**Use Case (รหัส):** UC-01  
**Scenario:** Displayname เกิน 30 ตัวอักษร  
**Preconditions:** –  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. Paste ชื่อยาว \>30 ตัวอักษร  
2. ตรวจ textbox

**Expected Result:** Textbox ตัดเหลือ 30 ตัวแรกอัตโนมัติ (ไม่มีข้อความแจ้งเตือน)  
**Test Data:** Displayname=“x”\*60  
**Priority:** Low

---

**Test Case ID:** TC01-9  
**Use Case (รหัส):** UC-01  
**Scenario:** ToS/PDPA not accepted  
**Preconditions:** –  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. ไม่ติ๊กยอมรับ ToS/PDPA  
2. กด Continue

**Expected Result:** Inline validation: “Please accept Terms of Service and Privacy Policy before continuing.”  
**Test Data:** –  
**Priority:** High

---

**Test Case ID:** TC01-10  
**Use Case (รหัส):** UC-01  
**Scenario:** Displayname มีอักขระพิเศษ/emoji  
**Preconditions:** –  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. กรอก “Neo🎧” หรือ “@Neo\!”  
2. กด Continue

**Expected Result:** Inline validation: “Displayname cannot contain special characters or emoji.”  
**Test Data:** Displayname=“Neo🎧”  
**Priority:** Medium

---

**Test Case ID:** TC01-11  
**Use Case (รหัส):** UC-01  
**Scenario:** DOB เป็นอนาคต (API validation case)  
**Preconditions:** –  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. เลือก DOB เป็นปีถัดไป (หรือส่งผ่าน API โดยตรง)  
2. กด Continue

**Expected Result:** Inline validation: “Date of birth must be in the past.”; ไม่อนุญาตให้สมัคร  
**Test Data:** DOB=อนาคต  
**Priority:** Medium

---

**Test Case ID:** TC01-12  
**Use Case (รหัส):** UC-01  
**Scenario:** Double submit  
**Preconditions:** –  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. กด Continue รัว ๆ

**Expected Result:** ระบบ submit ครั้งเดียว Toast: “Processing… Please wait.” (ไม่มีปุ่ม กดซ้ำไม่ได้)  
**Test Data:** –  
**Priority:** Low  
---

**Test Case ID:** TC01-13  
**Use Case (รหัส):** UC-01  
**Scenario:** OAuth state mismatch (CSRF)  
**Preconditions:** จำลองให้ state ที่ส่งไปไม่ตรงกับที่รับกลับ  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. เริ่มสมัครด้วย Google  
2. ดัดแปลงพารามิเตอร์ state ตอน redirect back

**Expected Result:** Dialog: “Security check failed. Please try again.” / ปุ่ม Close, Try again; ไม่สร้างบัญชี  
**Test Data:** state ผิด  
**Priority:** High

---

**Test Case ID:** TC01-14  
**Use Case (รหัส):** UC-01  
**Scenario:** PKCE code\_verifier missing/invalid  
**Preconditions:** เปิดใช้งาน PKCE  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. เริ่ม OAuth  
2. ส่ง code โดยไม่มี/ผิด code\_verifier

**Expected Result:** Toast: “Authentication failed. Please try again.” / ปุ่ม Retry; ไม่สร้างบัญชี  
**Test Data:** –  
**Priority:** High

---

**Test Case ID:** TC01-15  
**Use Case (รหัส):** UC-01  
**Scenario:** Google account ไม่มี email verified  
**Preconditions:** ใช้บัญชี Google ที่อีเมลไม่ยืนยัน  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google (email not verified)

**Expected Result:** Dialog: “Email not verified with Google.” / ปุ่ม Use another account, Cancel  
**Test Data:** บัญชี Google ทดสอบที่ไม่ verify  
**Priority:** Medium

---

**Test Case ID:** TC01-16  
**Use Case (รหัส):** UC-01  
**Scenario:** Token exchange timeout/retry  
**Preconditions:** จำลอง network timeout ที่ขั้นแลกเปลี่ยน token  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. สมัครด้วย Google  
2. token exchange timeout

**Expected Result:** Toast: “Network timeout. Please try again.” / ปุ่ม Retry; มี retry max N ครั้ง  
**Test Data:** –  
**Priority:** Medium

---

**Test Case ID:** TC01-17  
**Use Case (รหัส):** UC-01  
**Scenario:** เปิดลิงก์ ToS/Privacy จากฟอร์มสมัคร  
**Preconditions:** ออนไลน์ปกติ  
**Test Steps (ขั้นตอนแบบละเอียด):**

1. แตะลิงก์ Terms/Privacy จากหน้าสมัคร

**Expected Result:** เปิดลิงก์ได้ถูกต้อง (in-app browser)  
**Test Data:** –  
**Priority:** Low

**Business Rules:** 

* ต้องใช้ Google OAuth 2.0 ตาม scope: email, profile

* อีเมลจาก Google ต้องไม่ซ้ำกับบัญชีที่มีอยู่แล้ว (unique constraint)

* ผู้ใช้ต้องยอมรับ PDPA ก่อนเข้าใช้งาน → หากไม่ได้ยอมรับ ระบบต้อง block การสมัคร

* ทุกการสมัครต้องบันทึก audit log (user\_id, action, timestamp)

**Postconditions:**

* บัญชี Member ถูกสร้างและผูกกับ Google provider\_id

* เซสชันถูกสร้างและผู้ใช้ถูกนำเข้าแอป

* บันทึก consent (PDPA) และ audit log เรียบร้อย

---

### **UC-02 Sign in with Google**

**Actors:** Visitor, Google

**Description:** ผู้ใช้ที่มีบัญชี ผูกกับ Google อยู่แล้ว ต้องการเข้าสู่ระบบโดยใช้ Google OAuth เพื่อความสะดวกและรวดเร็ว ระบบต้องตรวจสอบ token และสร้างเซสชันให้ผู้ใช้เข้าสู่ระบบสำเร็จ

**Preconditions:**

* ผู้ใช้มีบัญชีที่ผูกกับ Google อยู่แล้วในระบบ

* แอปตั้งค่า Google OAuth (client\_id, redirect\_uri, scope=email, profile) เรียบร้อยแล้ว

**Trigger:** ผู้ใช้กด "Continue with Google"

**Main Flow:**

1. ผู้ใช้เลือก "Sign in with Google"

2. Redirect ไป Google → ยืนยันตัวตน

3. Google ส่ง token กลับ

4. ระบบตรวจสอบ token → match provider\_id/email กับบัญชีที่มีอยู่

5. ระบบสร้างเซสชันใหม่ → Login สำเร็จ

**Alternative Flows / Exceptions (รวม Test Scenarios):**

* ผู้ใช้กดยกเลิกบน Google ระบบพากลับไปหน้า Login  
  TC02-1: Cancel → ระบบพากลับไปหน้า Login และแจ้ง "Sign in canceled."  
  【Toast】

* token invalid/expired ระบบไม่อนุญาตให้เข้าสู่ระบบ  
  TC02-2: Token invalid → ระบบแจ้ง "Authentication failed. Please try again."  
  【Toast \+ Action: Retry】

* email พบในระบบแต่ยังไม่ link ระบบบังคับให้ทำการ link  
  TC02-3: Not linked → ระบบแจ้ง "Account not linked. Please verify."  
  【Dialog: Cancel/Verify】

* Replay token ถูกนำมาใช้ซ้ำ ระบบบล็อกและบันทึก log  
  TC02-4: Token reuse → ระบบแจ้ง "Invalid request. Please try again."  
  【Toast】

**Business Rules:**

* ต้องใช้ Google OAuth 2.0 ตาม scope: email, profile

* ระบบต้องตรวจสอบว่าบัญชีถูกผูกกับ Google แล้วก่อนอนุญาตให้เข้าสู่ระบบ

* ทุกการเข้าสู่ระบบต้องบันทึก audit log (user\_id, action, timestamp)

**Postconditions:**

* ผู้ใช้เข้าสู่ระบบสำเร็จและถูกพาไปหน้า Home

* ระบบสร้างเซสชันใหม่สำหรับผู้ใช้

* audit log ถูกบันทึกว่าเข้าสู่ระบบสำเร็จ

---