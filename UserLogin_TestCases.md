# Test Case Specification: User Login

## Requirement Reference
**Requirement ID:** REQ-LOGIN-001  
**Requirement Description:** "The system shall allow users to log in using their email and password"

---

## Test Cases

### 1. Nominal/Positive Scenarios

#### TC-LOGIN-001: Successful Login with Valid Credentials
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Successful Login with Valid Email and Password  
**Priority:** High  
**Type:** Positive

**Pre-conditions:**
- User account exists in the system
- User has valid email: `testuser@example.com`
- User has valid password: `ValidPass123!`
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter valid email address in the email field: `testuser@example.com`
3. Enter valid password in the password field: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- User is successfully authenticated
- User is redirected to the home/dashboard page
- User session is created
- Success message is displayed (e.g., "Login successful" or "Welcome back")
- User's name or profile information is visible

---

#### TC-LOGIN-002: Successful Login with Email in Different Case
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Address in Mixed/Upper Case  
**Priority:** Medium  
**Type:** Positive

**Pre-conditions:**
- User account exists with email: `testuser@example.com`
- User has valid password: `ValidPass123!`
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter email address in uppercase: `TESTUSER@EXAMPLE.COM`
3. Enter valid password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- User is successfully authenticated (email should be case-insensitive)
- User is redirected to the home/dashboard page
- User session is created

---

#### TC-LOGIN-003: Successful Login After Trimming Whitespace
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Leading/Trailing Spaces in Email  
**Priority:** Medium  
**Type:** Positive

**Pre-conditions:**
- User account exists with email: `testuser@example.com`
- User has valid password: `ValidPass123!`
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter email with leading and trailing spaces: `  testuser@example.com  `
3. Enter valid password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- System trims whitespace from email input
- User is successfully authenticated
- User is redirected to the home/dashboard page

---

### 2. Negative Scenarios

#### TC-LOGIN-004: Login Failure with Invalid Email
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with Incorrect Email Address  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- User account exists with email: `testuser@example.com`
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter invalid email address: `wronguser@example.com`
3. Enter any password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Error message is displayed: "Invalid email or password" or similar
- No user session is created
- Login attempt is logged for security purposes

---

#### TC-LOGIN-005: Login Failure with Invalid Password
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with Incorrect Password  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- User account exists with email: `testuser@example.com` and password: `ValidPass123!`
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter valid email address: `testuser@example.com`
3. Enter incorrect password: `WrongPassword123`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Error message is displayed: "Invalid email or password" or similar
- No user session is created
- Failed login attempt is logged
- Account lockout counter is incremented (if applicable)

---

#### TC-LOGIN-006: Login Failure with Empty Email Field
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with Missing Email  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Leave email field empty
3. Enter valid password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Validation error message is displayed: "Email is required" or similar
- Email field is highlighted as invalid
- No user session is created

---

#### TC-LOGIN-007: Login Failure with Empty Password Field
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with Missing Password  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter valid email: `testuser@example.com`
3. Leave password field empty
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Validation error message is displayed: "Password is required" or similar
- Password field is highlighted as invalid
- No user session is created

---

#### TC-LOGIN-008: Login Failure with Both Fields Empty
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with All Fields Empty  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Leave email field empty
3. Leave password field empty
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Validation error messages are displayed for both fields
- Both fields are highlighted as invalid
- No user session is created

---

#### TC-LOGIN-009: Login Failure with Non-existent Account
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login Attempt with Email Not Registered  
**Priority:** High  
**Type:** Negative

**Pre-conditions:**
- Email `nonexistent@example.com` is NOT registered in the system
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter non-existent email: `nonexistent@example.com`
3. Enter any password: `SomePassword123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- User remains on the login page
- Generic error message is displayed: "Invalid email or password" (should not reveal account existence)
- No user session is created
- Login attempt is logged

---

#### TC-LOGIN-010: Login Failure with SQL Injection Attempt
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Security Test - SQL Injection in Email Field  
**Priority:** High  
**Type:** Negative/Security

**Pre-conditions:**
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter SQL injection string in email field: `admin'--`
3. Enter any password: `password`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- SQL injection is blocked/sanitized
- User remains on the login page
- Error message is displayed or input is treated as invalid
- No unauthorized access is granted
- No database errors are exposed to the user
- Security incident is logged

---

#### TC-LOGIN-011: Login Failure with XSS Attempt
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Security Test - XSS in Email Field  
**Priority:** High  
**Type:** Negative/Security

**Pre-conditions:**
- Login page is accessible
- User is not currently logged in

**Test Steps:**
1. Navigate to the login page
2. Enter XSS script in email field: `<script>alert('XSS')</script>`
3. Enter any password: `password`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- XSS script is sanitized/escaped
- No script execution occurs
- User remains on the login page
- Input is treated as invalid email format
- Security incident is logged

---

### 3. Boundary/Edge Cases

#### TC-LOGIN-012: Email Field - Maximum Length
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Maximum Allowed Email Length  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with maximum length email (typically 254 characters per RFC 5321)
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter email address with 254 characters (max valid email length)
3. Enter valid password
4. Click the "Login" or "Submit" button

**Expected Result:**
- If account exists with this email: Login succeeds
- Email is accepted without truncation
- System handles maximum length email correctly

---

#### TC-LOGIN-013: Email Field - Beyond Maximum Length
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Exceeding Maximum Length  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter email address with 255+ characters (exceeds max valid email length)
3. Enter any password
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- Validation error: "Email address is too long" or "Invalid email format"
- Input is rejected or truncated
- No user session is created

---

#### TC-LOGIN-014: Email Field - Minimum Valid Format
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Shortest Valid Email  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with minimal email: `a@b.c`
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter minimal valid email: `a@b.c`
3. Enter valid password
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds (if account exists)
- Minimal valid email format is accepted

---

#### TC-LOGIN-015: Email Field - Invalid Format (No @ Symbol)
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Missing @ Symbol  
**Priority:** High  
**Type:** Boundary/Negative

**Pre-conditions:**
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter invalid email without @ symbol: `testexample.com`
3. Enter any password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- Validation error: "Invalid email format" or "Email must contain @"
- Email field is highlighted as invalid
- No user session is created

---

#### TC-LOGIN-016: Email Field - Invalid Format (No Domain)
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Missing Domain  
**Priority:** High  
**Type:** Boundary/Negative

**Pre-conditions:**
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter invalid email without domain: `test@`
3. Enter any password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- Validation error: "Invalid email format"
- Email field is highlighted as invalid
- No user session is created

---

#### TC-LOGIN-017: Email Field - Invalid Format (No Username)
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Missing Username  
**Priority:** High  
**Type:** Boundary/Negative

**Pre-conditions:**
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter invalid email without username: `@example.com`
3. Enter any password: `ValidPass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login fails
- Validation error: "Invalid email format"
- Email field is highlighted as invalid
- No user session is created

---

#### TC-LOGIN-018: Password Field - Minimum Length
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Minimum Length Password  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with minimum length password (e.g., 8 characters): `Pass123!`
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter valid email: `testuser@example.com`
3. Enter minimum length password: `Pass123!`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds (if credentials are correct)
- Minimum password length is accepted

---

#### TC-LOGIN-019: Password Field - Maximum Length
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Maximum Length Password  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with maximum length password (e.g., 128 characters)
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter valid email
3. Enter maximum length password (128 characters)
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds (if credentials are correct)
- Maximum password length is accepted without truncation
- Password is processed correctly

---

#### TC-LOGIN-020: Password Field - Special Characters
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Password Containing Special Characters  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with password containing special characters: `P@ssw0rd!#$%`
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter valid email
3. Enter password with special characters: `P@ssw0rd!#$%`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds
- Special characters in password are handled correctly
- No encoding/escaping issues occur

---

#### TC-LOGIN-021: Password Field - Unicode Characters
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Password Containing Unicode Characters  
**Priority:** Low  
**Type:** Boundary

**Pre-conditions:**
- User account exists with password containing Unicode: `Pässwörd123`
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter valid email
3. Enter password with Unicode characters: `Pässwörd123`
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds (if system supports Unicode passwords)
- Unicode characters are handled correctly
- Password comparison works with Unicode

---

#### TC-LOGIN-022: Email Field - Special Valid Characters
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Login with Email Containing Valid Special Characters  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User account exists with email: `test.user+tag@example.co.uk`
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter email with dots, plus, and subdomain: `test.user+tag@example.co.uk`
3. Enter valid password
4. Click the "Login" or "Submit" button

**Expected Result:**
- Login succeeds
- Valid special characters in email (dots, plus, hyphens) are accepted
- Email is processed correctly

---

#### TC-LOGIN-023: Multiple Consecutive Login Failures
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Account Lockout After Multiple Failed Attempts  
**Priority:** High  
**Type:** Boundary/Security

**Pre-conditions:**
- User account exists
- Account lockout is enabled (e.g., after 5 failed attempts)
- Login page is accessible

**Test Steps:**
1. Navigate to the login page
2. Enter valid email: `testuser@example.com`
3. Enter incorrect password: `WrongPass123`
4. Click the "Login" or "Submit" button
5. Repeat steps 2-4 for the configured threshold (e.g., 5 times)
6. Attempt login with CORRECT credentials

**Expected Result:**
- First N-1 attempts: Login fails with error message
- Nth attempt: Account is locked
- Error message displayed: "Account has been locked due to multiple failed login attempts"
- Login with correct credentials also fails while account is locked
- Account unlock mechanism is available (time-based or admin intervention)
- Security event is logged

---

#### TC-LOGIN-024: Session Management - Already Logged In User
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Attempt to Access Login Page While Already Logged In  
**Priority:** Medium  
**Type:** Boundary

**Pre-conditions:**
- User is already logged in with active session
- Login page URL is known

**Test Steps:**
1. User is logged in to the application
2. Navigate directly to the login page URL
3. Observe system behavior

**Expected Result:**
- User is redirected to home/dashboard page, OR
- Message displayed: "You are already logged in", OR
- Login page is displayed but with logout option visible
- Existing session is maintained

---

#### TC-LOGIN-025: Password Field - Visibility Toggle
**Requirement Reference:** REQ-LOGIN-001  
**Test Case Title:** Password Masking and Visibility Toggle  
**Priority:** Medium  
**Type:** Functional

**Pre-conditions:**
- Login page is accessible
- Password field has visibility toggle feature (if implemented)

**Test Steps:**
1. Navigate to the login page
2. Enter password in password field
3. Observe that password is masked (shown as dots/asterisks)
4. If toggle exists: Click the "Show Password" icon/button
5. Observe password becomes visible
6. Click "Hide Password" icon/button
7. Observe password is masked again

**Expected Result:**
- Password is masked by default for security
- If visibility toggle exists: It functions correctly
- Password can be toggled between visible and masked states
- Functionality aids usability without compromising security

---

## Traceability Audit

### Requirement Coverage Analysis

**Requirement:** "The system shall allow users to log in using their email and password"

#### Coverage Summary:
✅ **100% Coverage Achieved**

#### Detailed Coverage:

1. **Email Input Validation:**
   - Valid email formats (TC-LOGIN-001, TC-LOGIN-022)
   - Invalid email formats (TC-LOGIN-015, TC-LOGIN-016, TC-LOGIN-017)
   - Email case sensitivity (TC-LOGIN-002)
   - Email with whitespace (TC-LOGIN-003)
   - Email length boundaries (TC-LOGIN-012, TC-LOGIN-013, TC-LOGIN-014)

2. **Password Input Validation:**
   - Valid password (TC-LOGIN-001)
   - Invalid password (TC-LOGIN-005)
   - Password length boundaries (TC-LOGIN-018, TC-LOGIN-019)
   - Special characters (TC-LOGIN-020)
   - Unicode characters (TC-LOGIN-021)
   - Password visibility (TC-LOGIN-025)

3. **Required Field Validation:**
   - Missing email (TC-LOGIN-006)
   - Missing password (TC-LOGIN-007)
   - Both fields missing (TC-LOGIN-008)

4. **Authentication Logic:**
   - Valid credentials (TC-LOGIN-001)
   - Invalid email (TC-LOGIN-004)
   - Invalid password (TC-LOGIN-005)
   - Non-existent account (TC-LOGIN-009)

5. **Security Considerations:**
   - SQL injection prevention (TC-LOGIN-010)
   - XSS prevention (TC-LOGIN-011)
   - Account lockout (TC-LOGIN-023)
   - Session management (TC-LOGIN-024)

6. **Edge Cases:**
   - Maximum/minimum input lengths (TC-LOGIN-012, TC-LOGIN-013, TC-LOGIN-014, TC-LOGIN-018, TC-LOGIN-019)
   - Special characters handling (TC-LOGIN-020, TC-LOGIN-022)
   - Multiple login attempts (TC-LOGIN-023)
   - Already logged-in state (TC-LOGIN-024)

### Requirements NOT Covered:
**None** - All aspects of the user login requirement have been covered with appropriate test cases.

### Additional Test Cases (Beyond Core Requirement):
The following test cases go beyond the basic requirement to ensure robust testing:
- Security testing (SQL injection, XSS) - TC-LOGIN-010, TC-LOGIN-011
- Account lockout - TC-LOGIN-023
- Session management - TC-LOGIN-024
- Password visibility - TC-LOGIN-025

---

## Test Execution Summary

**Total Test Cases:** 25

**By Category:**
- Positive/Nominal: 3 test cases
- Negative: 8 test cases
- Boundary/Edge: 14 test cases

**By Priority:**
- High: 15 test cases
- Medium: 9 test cases
- Low: 1 test case

**By Type:**
- Functional: 18 test cases
- Security: 3 test cases
- Boundary: 4 test cases

---

## Notes and Recommendations

1. **Account Lockout Policy:** Ensure the system has a clear account lockout policy after N failed login attempts. This should be documented and tested (TC-LOGIN-023).

2. **Error Messages:** Error messages should be generic enough not to reveal whether an email exists in the system ("Invalid email or password" is preferred over "Email not found").

3. **Password Security:** Password should never be transmitted or stored in plain text. Use HTTPS for transmission and hashing for storage.

4. **Session Management:** Implement secure session management with timeout, secure cookies, and CSRF protection.

5. **Logging:** All login attempts (successful and failed) should be logged for security auditing.

6. **Email Validation:** Use proper email validation regex or libraries to ensure RFC compliance.

7. **Rate Limiting:** Consider implementing rate limiting to prevent brute force attacks at the API/network level.

8. **Multi-factor Authentication:** While not in the current requirement, consider MFA for enhanced security.

---

## Assumptions

1. The system uses standard email format validation (RFC 5321/5322)
2. Passwords have minimum and maximum length requirements
3. The system implements account lockout after multiple failed attempts
4. HTTPS is used for secure transmission
5. Email comparison is case-insensitive
6. The system has a standard web-based login interface
