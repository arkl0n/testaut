# User Login Test Suite

## Overview
This test suite provides comprehensive test coverage for the user login functionality based on the requirement:

**Requirement ID:** REQ-LOGIN-001  
**Requirement:** "The system shall allow users to log in using their email and password"

## Files in This Test Suite

1. **UserLogin_TestCases.md** - Detailed test case specifications with:
   - 25 comprehensive test cases
   - Test case IDs, titles, pre-conditions, steps, and expected results
   - Coverage of positive, negative, and boundary scenarios
   - Traceability audit confirming 100% requirement coverage

2. **UserLogin_Tests.robot** - Robot Framework automated test implementation
   - Executable test cases using Selenium2Library
   - All 25 test cases automated
   - Reusable keywords and variables
   - Ready to run against a web application

3. **README_UserLogin_Tests.md** - This file

## Test Coverage Summary

### Total: 25 Test Cases

#### By Category:
- **Positive/Nominal Scenarios:** 3 test cases
  - TC-LOGIN-001: Successful login with valid credentials
  - TC-LOGIN-002: Login with email in different case
  - TC-LOGIN-003: Login after trimming whitespace

- **Negative Scenarios:** 8 test cases
  - TC-LOGIN-004: Invalid email
  - TC-LOGIN-005: Invalid password
  - TC-LOGIN-006: Empty email field
  - TC-LOGIN-007: Empty password field
  - TC-LOGIN-008: Both fields empty
  - TC-LOGIN-009: Non-existent account
  - TC-LOGIN-010: SQL injection attempt (security)
  - TC-LOGIN-011: XSS attempt (security)

- **Boundary/Edge Cases:** 14 test cases
  - Email validation (format, length, special characters)
  - Password validation (length, special characters, Unicode)
  - Account lockout
  - Session management
  - Password visibility toggle

#### By Priority:
- **High:** 15 test cases
- **Medium:** 9 test cases
- **Low:** 1 test case

## How to Use This Test Suite

### Prerequisites
1. **Robot Framework** installed
2. **Selenium2Library** installed
3. **Web browser** (Firefox recommended based on existing config)
4. **WebDriver** for your browser (geckodriver for Firefox)

### Installation
```bash
# Install Robot Framework
pip install robotframework

# Install Selenium Library
pip install robotframework-seleniumlibrary

# Install browser driver (example for Firefox)
# Download geckodriver from https://github.com/mozilla/geckodriver/releases
# Add to PATH
```

### Configuration
Before running the tests, update the following variables in `UserLogin_Tests.robot`:

```robot
${LOGIN_URL}          http://localhost/login    # Your login page URL
${VALID_EMAIL}        testuser@example.com      # Valid test account email
${VALID_PASSWORD}     ValidPass123!             # Valid test account password
${EMAIL_FIELD}        id=email                  # Email field locator
${PASSWORD_FIELD}     id=password               # Password field locator
${LOGIN_BUTTON}       id=login-button           # Login button locator
${ERROR_MESSAGE}      id=error-message          # Error message locator
```

### Running the Tests

#### Run All Tests
```bash
robot UserLogin_Tests.robot
```

#### Run Specific Test by Tag
```bash
# Run only positive tests
robot --include positive UserLogin_Tests.robot

# Run only high-priority tests
robot --include high-priority UserLogin_Tests.robot

# Run only security tests
robot --include security UserLogin_Tests.robot

# Run smoke tests
robot --include smoke UserLogin_Tests.robot
```

#### Run Specific Test by Name
```bash
robot --test "TC-LOGIN-001*" UserLogin_Tests.robot
```

#### Run Tests with Custom Browser
```bash
robot --variable BROWSER:chrome UserLogin_Tests.robot
```

### Test Results
After execution, Robot Framework generates:
- **log.html** - Detailed execution log
- **report.html** - High-level test report
- **output.xml** - Machine-readable results

## Test Case Details

### Nominal/Positive Scenarios
These verify the happy path where users successfully log in:
- Valid credentials with correct email and password
- Email case-insensitivity
- Whitespace handling

### Negative Scenarios
These verify proper error handling:
- Invalid credentials (wrong email or password)
- Missing required fields
- Non-existent accounts
- Security attacks (SQL injection, XSS)

### Boundary/Edge Cases
These test the limits and special conditions:
- Email format validation (missing @, domain, username)
- Email length limits (min/max)
- Password length limits (min/max)
- Special characters in email and password
- Unicode character support
- Account lockout after multiple failures
- Session management
- Password visibility toggle

## Security Testing
The suite includes critical security tests:

1. **SQL Injection Prevention (TC-LOGIN-010)**
   - Validates input sanitization
   - Ensures no database errors are exposed
   - Prevents unauthorized access

2. **XSS Prevention (TC-LOGIN-011)**
   - Validates output encoding
   - Prevents script execution
   - Ensures user safety

3. **Account Lockout (TC-LOGIN-023)**
   - Prevents brute force attacks
   - Validates lockout mechanism
   - Tests threshold configuration

## Customization Guide

### Adding New Test Cases
1. Add test case specification to `UserLogin_TestCases.md`
2. Implement in `UserLogin_Tests.robot` following the pattern:
```robot
TC-NEW-001: Your Test Name
    [Documentation]    Description of what this tests
    [Tags]    category    priority
    Go To    ${LOGIN_URL}
    # Your test steps here
    # Your assertions here
```

### Modifying Locators
Update the `*** Variables ***` section in `UserLogin_Tests.robot`:
```robot
${EMAIL_FIELD}        xpath=//input[@name='email']
${PASSWORD_FIELD}     css=#password-input
${LOGIN_BUTTON}       xpath=//button[text()='Sign In']
```

### Adding New Keywords
Add reusable keywords in the `*** Keywords ***` section:
```robot
Your Custom Keyword
    [Documentation]    What this keyword does
    [Arguments]    ${arg1}    ${arg2}
    # Implementation here
    [Return]    ${result}
```

## Traceability Matrix

| Requirement Aspect | Test Cases |
|-------------------|------------|
| Email input validation | TC-LOGIN-001 to TC-LOGIN-003, TC-LOGIN-012 to TC-LOGIN-017, TC-LOGIN-022 |
| Password input validation | TC-LOGIN-001, TC-LOGIN-005, TC-LOGIN-018 to TC-LOGIN-021, TC-LOGIN-025 |
| Required field validation | TC-LOGIN-006 to TC-LOGIN-008 |
| Authentication logic | TC-LOGIN-001, TC-LOGIN-004, TC-LOGIN-005, TC-LOGIN-009 |
| Security | TC-LOGIN-010, TC-LOGIN-011, TC-LOGIN-023 |
| Session management | TC-LOGIN-024 |

## Best Practices

1. **Test Data Management**
   - Use dedicated test accounts
   - Reset test data between runs
   - Don't use production credentials

2. **Test Execution**
   - Run tests in isolated environment
   - Clear browser cache/cookies between suite runs
   - Use headless mode for CI/CD

3. **Maintenance**
   - Update locators when UI changes
   - Review and update test data regularly
   - Keep documentation synchronized with tests

4. **Reporting**
   - Review test results after each run
   - Document any failures with screenshots
   - Track test metrics over time

## CI/CD Integration

### GitHub Actions Example
```yaml
name: User Login Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install dependencies
        run: |
          pip install robotframework
          pip install robotframework-seleniumlibrary
      - name: Run tests
        run: robot --outputdir results UserLogin_Tests.robot
      - name: Upload results
        uses: actions/upload-artifact@v2
        with:
          name: test-results
          path: results/
```

## Troubleshooting

### Common Issues

1. **"Element not found" errors**
   - Verify locators match your application
   - Check if page is fully loaded (add waits)
   - Inspect element IDs/classes in browser

2. **Tests fail unexpectedly**
   - Check if test data (accounts) exist
   - Verify application is running
   - Check network connectivity

3. **Timeout errors**
   - Increase timeout values
   - Check application performance
   - Verify correct URL configuration

4. **Browser driver issues**
   - Ensure driver version matches browser version
   - Verify driver is in system PATH
   - Try different browser/driver combination

## Contact and Support

For questions or issues with this test suite:
1. Review the test case documentation in `UserLogin_TestCases.md`
2. Check Robot Framework documentation: https://robotframework.org/
3. Check SeleniumLibrary documentation: https://robotframework.org/SeleniumLibrary/

## Version History

- **v1.0** - Initial release with 25 comprehensive test cases covering all aspects of user login functionality

## License

This test suite is provided as-is for quality assurance purposes.
