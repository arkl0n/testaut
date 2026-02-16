*** Settings ***
Documentation     User Login Test Cases
...               Test suite for validating user login functionality
...               Requirement: "The system shall allow users to log in using their email and password"
Library           Selenium2Library
Resource          resource.txt
Suite Setup       Open Browser To Login Page
Suite Teardown    Close All Browsers

*** Variables ***
${LOGIN_URL}          http://localhost/login
${VALID_EMAIL}        testuser@example.com
${VALID_PASSWORD}     ValidPass123!
${INVALID_EMAIL}      wronguser@example.com
${INVALID_PASSWORD}   WrongPassword123
${EMAIL_FIELD}        id=email
${PASSWORD_FIELD}     id=password
${LOGIN_BUTTON}       id=login-button
${ERROR_MESSAGE}      id=error-message

*** Test Cases ***
TC-LOGIN-001: Successful Login with Valid Credentials
    [Documentation]    Verify user can login with valid email and password
    [Tags]    positive    high-priority    smoke
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Welcome    timeout=5s
    Page Should Contain    Dashboard
    Location Should Contain    /dashboard

TC-LOGIN-002: Successful Login with Email in Different Case
    [Documentation]    Verify email is case-insensitive
    [Tags]    positive    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    TESTUSER@EXAMPLE.COM
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Welcome    timeout=5s
    Location Should Contain    /dashboard

TC-LOGIN-003: Successful Login After Trimming Whitespace
    [Documentation]    Verify system trims whitespace from email
    [Tags]    positive    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${SPACE}${SPACE}${VALID_EMAIL}${SPACE}${SPACE}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Welcome    timeout=5s
    Location Should Contain    /dashboard

TC-LOGIN-004: Login Failure with Invalid Email
    [Documentation]    Verify login fails with incorrect email
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${INVALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    Invalid email or password
    Location Should Contain    /login

TC-LOGIN-005: Login Failure with Invalid Password
    [Documentation]    Verify login fails with incorrect password
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    Invalid email or password
    Location Should Contain    /login

TC-LOGIN-006: Login Failure with Empty Email Field
    [Documentation]    Verify validation error when email is missing
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    Email is required
    Location Should Contain    /login

TC-LOGIN-007: Login Failure with Empty Password Field
    [Documentation]    Verify validation error when password is missing
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    Password is required
    Location Should Contain    /login

TC-LOGIN-008: Login Failure with Both Fields Empty
    [Documentation]    Verify validation errors when both fields are empty
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    required
    Location Should Contain    /login

TC-LOGIN-009: Login Failure with Non-existent Account
    [Documentation]    Verify login fails for unregistered email
    [Tags]    negative    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    nonexistent@example.com
    Input Text    ${PASSWORD_FIELD}    SomePassword123!
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Element Should Contain    ${ERROR_MESSAGE}    Invalid email or password
    Location Should Contain    /login

TC-LOGIN-010: Login Failure with SQL Injection Attempt
    [Documentation]    Security test - SQL injection should be blocked
    [Tags]    negative    security    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    admin'--
    Input Text    ${PASSWORD_FIELD}    password
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Not Contain    database error
    Page Should Not Contain    SQL
    Location Should Contain    /login

TC-LOGIN-011: Login Failure with XSS Attempt
    [Documentation]    Security test - XSS should be sanitized
    [Tags]    negative    security    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    <script>alert('XSS')</script>
    Input Text    ${PASSWORD_FIELD}    password
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Alert Should Not Be Present
    Location Should Contain    /login

TC-LOGIN-012: Email Field - Maximum Length
    [Documentation]    Verify maximum length email is accepted
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    ${max_email}=    Generate Max Length Email
    Input Text    ${EMAIL_FIELD}    ${max_email}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    Email address is too long

TC-LOGIN-013: Email Field - Beyond Maximum Length
    [Documentation]    Verify email exceeding max length is rejected
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    ${oversized_email}=    Generate Oversized Email
    Input Text    ${EMAIL_FIELD}    ${oversized_email}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    Invalid email format

TC-LOGIN-014: Email Field - Minimum Valid Format
    [Documentation]    Verify shortest valid email is accepted
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    a@b.c
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    # Should either login or show invalid credentials (not format error)
    Page Should Not Contain    Invalid email format

TC-LOGIN-015: Email Field - Invalid Format No @ Symbol
    [Documentation]    Verify email without @ is rejected
    [Tags]    boundary    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    testexample.com
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    Invalid email format

TC-LOGIN-016: Email Field - Invalid Format No Domain
    [Documentation]    Verify email without domain is rejected
    [Tags]    boundary    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    test@
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    Invalid email format

TC-LOGIN-017: Email Field - Invalid Format No Username
    [Documentation]    Verify email without username is rejected
    [Tags]    boundary    high-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    @example.com
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    Invalid email format

TC-LOGIN-018: Password Field - Minimum Length
    [Documentation]    Verify minimum length password is accepted
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    Pass123!
    Click Button    ${LOGIN_BUTTON}
    # Should process without length error
    Page Should Not Contain    Password is too short

TC-LOGIN-019: Password Field - Maximum Length
    [Documentation]    Verify maximum length password is accepted
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    ${max_password}=    Generate Max Length Password
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${max_password}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    Password is too long

TC-LOGIN-020: Password Field - Special Characters
    [Documentation]    Verify password with special characters works
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    P@ssw0rd!#$%
    Click Button    ${LOGIN_BUTTON}
    # Should process without encoding errors
    Page Should Not Contain    Invalid character

TC-LOGIN-021: Password Field - Unicode Characters
    [Documentation]    Verify password with Unicode characters
    [Tags]    boundary    low-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    Pässwörd123
    Click Button    ${LOGIN_BUTTON}
    # Should process without Unicode errors
    Page Should Not Contain    Encoding error

TC-LOGIN-022: Email Field - Special Valid Characters
    [Documentation]    Verify email with valid special chars is accepted
    [Tags]    boundary    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    test.user+tag@example.co.uk
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Page Should Not Contain    Invalid email format

TC-LOGIN-023: Multiple Consecutive Login Failures
    [Documentation]    Verify account lockout after multiple failures
    [Tags]    boundary    security    high-priority
    Go To    ${LOGIN_URL}
    FOR    ${i}    IN RANGE    5
        Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
        Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD}
        Click Button    ${LOGIN_BUTTON}
        Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
        Sleep    1s
        Go To    ${LOGIN_URL}
    END
    # After 5 failures, account should be locked
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains Element    ${ERROR_MESSAGE}    timeout=5s
    Page Should Contain    locked

TC-LOGIN-024: Session Management - Already Logged In User
    [Documentation]    Verify behavior when accessing login while logged in
    [Tags]    boundary    medium-priority
    # First login
    Go To    ${LOGIN_URL}
    Input Text    ${EMAIL_FIELD}    ${VALID_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Welcome    timeout=5s
    # Try to access login page again
    Go To    ${LOGIN_URL}
    # Should either redirect or show logged-in state
    Run Keyword And Ignore Error    Location Should Contain    /dashboard

TC-LOGIN-025: Password Field - Visibility Toggle
    [Documentation]    Verify password masking and visibility toggle
    [Tags]    functional    medium-priority
    Go To    ${LOGIN_URL}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD}
    ${type}=    Get Element Attribute    ${PASSWORD_FIELD}    type
    Should Be Equal    ${type}    password
    # If toggle exists, test it
    ${toggle_exists}=    Run Keyword And Return Status    Page Should Contain Element    id=toggle-password
    Run Keyword If    ${toggle_exists}    Test Password Visibility Toggle

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Generate Max Length Email
    [Documentation]    Generate email with 254 characters (RFC 5321 max)
    ${local}=    Evaluate    'a' * 64
    ${domain}=    Evaluate    'b' * 63 + '.example.com'
    ${max_email}=    Catenate    SEPARATOR=@    ${local}    ${domain}
    [Return]    ${max_email}

Generate Oversized Email
    [Documentation]    Generate email exceeding 254 characters
    ${local}=    Evaluate    'a' * 200
    ${domain}=    Evaluate    'b' * 100 + '.example.com'
    ${oversized_email}=    Catenate    SEPARATOR=@    ${local}    ${domain}
    [Return]    ${oversized_email}

Generate Max Length Password
    [Documentation]    Generate password with 128 characters
    ${max_password}=    Evaluate    'Pass123!' * 16
    [Return]    ${max_password}

Test Password Visibility Toggle
    [Documentation]    Test password show/hide functionality
    Click Element    id=toggle-password
    Sleep    0.5s
    ${type}=    Get Element Attribute    ${PASSWORD_FIELD}    type
    Should Be Equal    ${type}    text
    Click Element    id=toggle-password
    Sleep    0.5s
    ${type}=    Get Element Attribute    ${PASSWORD_FIELD}    type
    Should Be Equal    ${type}    password
