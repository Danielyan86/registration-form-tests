*** Settings ***
Documentation          Registration Form Test Suite
Library                SeleniumLibrary                                                        timeout=5s
Library                ${CURDIR}/../libraries/RegistrationLibrary.py
Test Setup             Start Browser
Test Teardown          End Browser

*** Variables ***
# Test data
${VALID_FIRST_NAME}    John
${VALID_LAST_NAME}     Doe
${VALID_PHONE}         02902243881
${VALID_COUNTRY}       New Zealand
${VALID_EMAIL}         john.doe@example.com
${VALID_PASSWORD}      password123
${INVALID_EMAIL}       invalid_email

# Page static text
${PAGE_TITLE}          CHALLENGE - Spot the BUGS!
${PAGE_DESCRIPTION}    This page contains at least 15 bugs. How many of them can you spot?
@{FIELD_LABELS}        First Name                                                             Last Name*    Phone number*    Country    Email address*    Password*
${TIMEOUT}             10s

*** Test Cases ***
Verify Page Static Content
    Page Should Contain    ${PAGE_TITLE}
    Page Should Contain    ${PAGE_DESCRIPTION}

Verify Field Labels
    FOR                    ${label}                                             IN                    @{FIELD_LABELS}
    Page Should Contain    ${label}
    END

Valid Registration
    [Documentation]        Test registration with valid data
    Register User          ${VALID_FIRST_NAME}                                  ${VALID_LAST_NAME}    ${VALID_PHONE}
    ...                    ${VALID_COUNTRY}                                     ${VALID_EMAIL}        ${VALID_PASSWORD}
    Page Should Contain    Successfully registered the following information

Invalid Email Registration
    [Documentation]        Test registration with invalid email format
    Register User          ${VALID_FIRST_NAME}                                  ${VALID_LAST_NAME}    ${VALID_PHONE}
    ...                    ${VALID_COUNTRY}                                     ${INVALID_EMAIL}      ${VALID_PASSWORD}
    Page Should Contain    Please enter a valid email address




