# **UC-01 สมัครด้วย Google (Sign up with Google)**

**UC ID:** UC-01  
 **Module:** Authentication  
 **Priority:** High  
 **Risk:** High  
 **Owner:** BA  
 **Last Updated:** 2025-09-18

---

## **Preconditions & Triggers**

**Preconditions:**

* ผู้ใช้ยังไม่มีบัญชีในระบบ

* แอปตั้งค่า Google OAuth (client\_id, redirect\_uri, scope=email, profile) เรียบร้อยแล้ว

**Trigger:** ผู้ใช้กดปุ่ม "Sign up with Google"  
 **Primary Actor:** Visitor  
 **Secondary Systems:** Google (SSO Provider)

---

## **Screen Mapping**

* **SC-01 Onboarding** → หน้าแรก แสดงปุ่ม Sign Up / Sign In

* **SC-02 Sign up** → หน้าเลือกวิธีสมัคร มีปุ่ม “Sign up with Google”

* **WG-01 Google OAuth** → หน้ายืนยันตัวตน Google (เลือกบัญชี / ยกเลิก / ยืนยัน)

* **SC-04 Sign up with Google Step 2** → ฟอร์มสมัครสมาชิก (Displayname, DOB, Gender, ToS/PDPA)

* **SC-06 Home menu** → หน้า Home หลังสมัครสำเร็จ \+ Toast “Signed up\!”

---

## **Element Mapping (อ้างอิง Design Spec)**

### **SC-01 Onboarding**

* SC-01.btn-signup → ปุ่ม “Sign Up”

  ### **SC-02 Sign up**

* SC-02.btn-google → ปุ่ม “Sign up with Google”

  ### **WG-01 Google OAuth**

* WG-01.btn-continue → ปุ่ม Continue (Google OAuth)

  ### **SC-04 Sign up with Google (Step 2: Profile Form)**

* SC-04.input-displayname → ฟิลด์ Displayname (≤30 ตัวอักษร, ไม่ซ้ำ, ห้าม special/emoji)

* SC-04.input-dob → ฟิลด์ Date of Birth (ไม่อนุญาตเลือกอนาคต)

* SC-04.input-gender → Female / Male / Other

* SC-04.chk-pdpa → Checkbox “I accept ToS/PDPA”

* SC-04.btn-continue → ปุ่ม Continue

  ### **SC-06 Home menu**

* SC-06.toast-success → Toast “Signed up\!”

  ### **Shared Toasts / Errors (WG-02 → WG-09)**

* WG-02: “Signed up\!”

* WG-03: “Sign up canceled.”

* WG-04: “Authentication failed. Please try again.”

* WG-05: “Cannot sign up without email permission.”

* WG-07: “Displayname already taken.”

* WG-08: “Processing… Please wait.”

* WG-09: “Security check failed. Please try again.”

---

## **Main Flow**

1. **SC-01:** ผู้ใช้เลือก Sign Up → ไปที่ SC-02

2. **SC-02:** ผู้ใช้กด “Sign up with Google” → ไปที่ WG-01

3. **WG-01:** Google OAuth ส่ง token กลับ → ระบบตรวจสอบ token และดึง email/profile

4. **SC-04:** ผู้ใช้กรอก Displayname, DOB, Gender, ติ๊ก ToS/PDPA → กด Continue

5. **SC-06:** ระบบสร้างบัญชีใหม่ \+ เซสชัน → แสดงข้อความ “Signed up\!” → หน้า Home

---

## **Exception Mapping**

* **TC01-1:** Cancel บนหน้า Google → SC-02 / WG-03 | “Sign up canceled.”

* **TC01-2:** Token invalid/expired → SC-02 / WG-04 | “Authentication failed. Please try again.”

* **TC01-3:** Duplicate email → SC-06 | Redirect หน้า Home (ไม่มีข้อความแจ้งเตือน)

* **TC01-4:** Email scope missing → SC-02 / WG-05 | “Cannot sign up without email permission.”

* **TC01-6:** Missing required fields → SC-04 | “Please fill in all required fields.”

* **TC01-7:** Duplicate displayname → SC-04 / WG-07 | “Displayname already taken.”

* **TC01-8:** Displayname \>30 chars → SC-04 | ตัดเหลือ 30 ตัวอักษรอัตโนมัติ (ไม่มีข้อความแจ้งเตือน)

* **TC01-9:** ToS/PDPA not accepted → SC-04 | “Please accept Terms of Service and Privacy Policy before continuing.”

* **TC01-10:** Displayname มีอักขระพิเศษ/emoji → SC-04 | “Displayname cannot contain special characters or emoji.”

* **TC01-11:** DOB เป็นอนาคต → SC-04 | “Date of birth must be in the past.”

* **TC01-12:** Double submit → SC-04 / WG-08 | “Processing… Please wait.”

* **TC01-13:** OAuth state mismatch (CSRF) → WG-09 | “Security check failed. Please try again.”

* **TC01-14:** PKCE code\_verifier missing/invalid → SC-02 / WG-04 | “Authentication failed. Please try again.”

---

## **Business Rules & Postconditions**

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

## **Acceptance Criteria**

* **AC-1 สำเร็จ:**  
   Given ผู้ใช้ใหม่ไม่มีบัญชีในระบบ  
   When กด Sign up with Google → ยืนยันสำเร็จ และกรอกข้อมูลครบ  
   Then ระบบสร้างบัญชีใหม่, แสดง “Signed up\!” (WG-02), และพาไปหน้า Home

* **AC-2 ยกเลิกที่ Google:**  
   Given ผู้ใช้กดยกเลิกบนหน้า Google OAuth  
   When กลับสู่แอป  
   Then ระบบแสดง “Sign up canceled.” (WG-03)

* **AC-3 ข้อมูลไม่ครบ:**  
   Given ผู้ใช้ไม่กรอก Displayname / DOB / Gender หรือไม่ได้ติ๊ก PDPA  
   When กด Continue  
   Then ระบบแสดง inline error “Please fill in all required fields.”

* **AC-4 Validation:**

  * Displayname ≤30 ตัวอักษร และห้าม emoji/special characters

  * DOB ต้องเป็นอดีต

  * Duplicate displayname → “Displayname already taken.” (WG-07)

---

## **Analytics & Audit**

* **Event: เริ่มสมัคร** → Trigger: SC-02.btn-google

* **Event: OAuth ตอบกลับ** → Trigger: WG-01.btn-continue | Parameters: {email (mask), result}

* **Event: Submit โปรไฟล์สมัคร** → Trigger: SC-04.btn-continue | Parameters: {displayname, DOB, gender, consent}

* **Event: สมัครสำเร็จ** → Trigger: SC-06.toast-success | Parameters: {user\_id, provider\_id, session\_id}

* **Audit:** ต้องบันทึกทุกครั้งที่มีการสมัคร ไม่ว่าจะสำเร็จหรือล้มเหลว


### Shared Widgets

**WG-01 (Popup: Google Sign-In Consent)**

* ข้อความ:

  * Header: `"Re:Play" wants to use "Google.com" to Sign Up`

  * Subtext: `This allows the app and website to share information about you`

* ไอคอน: ไม่มี

* ตำแหน่ง: กลางหน้าจอแบบ overlay

* ปุ่ม:

  * Cancel (ซ้าย)

  * Continue (ขวา)
  
- **WG-02 (Toast: สำเร็จ)**
  - ข้อความ: "Signed up!"
  - ไอคอน: icon-placeholder
  - ตำแหน่ง: แถบด้านบนของหน้าจอ, ปิดอัตโนมัติภายใน 3 วินาที
  - ปุ่ม: ไม่มี

- **WG-03 (Toast: ยกเลิก)**
  - ข้อความ: "Sign up canceled."
  - ไอคอน: icon-placeholder
  - ตำแหน่ง: แถบด้านบนของหน้าจอ, ปิดอัตโนมัติภายใน 3 วินาที
  - ปุ่ม: ไม่มี

- **WG-04 (Toast: ล้มเหลว)**
  - ข้อความ: "Authentication failed. Please try again."
  - ตำแหน่ง: แถบด้านบนของหน้าจอ, ปิดอัตโนมัติภายใน 3 วินาที
  - ปุ่ม: Retry (ด้านขวาข้อความ)

- **WG-05 (Popup: สิทธิ์อีเมล)**
  - ข้อความ: "Cannot sign up without email permission."
  - ไอคอน: icon-placeholder
  - ตำแหน่ง: กลางหน้าจอแบบ overlay
  - ปุ่ม:
    - Cancel (ซ้าย)
    - Try again (ขวา)

- **WG-06 (Inline Error: ทั่วไป)**
  - ข้อความ: "Invalid request. Please try again."
  - ไอคอน: ไม่มี
  - ตำแหน่ง: ใต้ช่องฟิลด์ที่เกี่ยวข้อง
  - ปุ่ม: ไม่มี

- **WG-07 (Inline Error: ชื่อซ้ำ)**
  - ข้อความ: "Displayname already taken."
  - ไอคอน: ไม่มี
  - ตำแหน่ง: ใต้ `SC-04.input-displayname`
  - ปุ่ม: ไม่มี

- **WG-08 (Modal: กำลังประมวลผล)**
  - ข้อความ: "Processing… Please wait."
  - ไอคอน: icon-placeholder
  - ตำแหน่ง: กลางหน้าจอแบบ modal (บล็อกการกดทุกอย่างจนกว่าจะปิด)
  - ปุ่ม: ไม่มี

- **WG-09 (Popup: ความปลอดภัย)**
  - ข้อความ: "Security check failed. Please try again."
  - ไอคอน: icon-placeholder
  - ตำแหน่ง: กลางหน้าจอแบบ overlay
  - ปุ่ม:
    - OK (กลาง)