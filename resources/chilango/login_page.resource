*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Variables    ./login_locators.yaml

*** Variables ***
${TIME} =       10s
${SH_TIME} =    1s
${ENVIRONMENT}

*** Keywords ***
Load Login Page
    Wait For Condition               return document.readyState == "complete"    ${TIME}
    Wait Until Element is Visible    ${login_locators.label_registrate}          ${TIME}

Input Text In Email Field
    [Arguments]    ${EMAIL}
    Wait Until Element Is Visible    ${login_locators.email_input}               ${TIME}
    Input Text                       ${login_locators.email_input}               ${EMAIL}

Input Text In Password Field
    [Arguments]    ${PASSWORD}        
    Wait Until Element Is Visible    ${login_locators.password_input}            ${TIME}
    Input Text                       ${login_locators.password_input}            ${PASSWORD}

Click on Login Button Inside The Login Page
    Wait Until Element Is Visible    ${login_locators.login_button_Inside}       ${TIME}
    Click Element                    ${login_locators.login_button_Inside}

Text on Screen
    ${PAGE_TEXT} =    Get Text    tag:body
    Log    ${PAGE_TEXT}    
    ${PAGE_SOURCE} =    Get Source
    Log    ${PAGE_SOURCE}

Obtain Text From JS
    Sleep    2
    ${TEXT} =    Execute JavaScript
    ...    var selectors = ['.toast', '.notification', '.alert', '.error', '.warning',
    ...        '[role="alert"]', '.swal-modal', '.popup', '.message',
    ...        '.invalid-feedback', '.error-message', '.validation-error',
    ...        '.field-error', '.form-error', '.help-block'];
    ...    for (var sel of selectors) {
    ...        var element = document.querySelector(sel);
    ...        if (element && element.textContent.tolowerCase().includes('include')) {
    ...            return element.textContent;
    ...        }
    ...    }
    ...    If (document.body.textContent.tolowerCase().includes('include')) {
    ...        return document.body.textContent;
    ...    }
    Should Not Be Empty    ${TEXT}    The text does not contain the expected content
    Log    ${TEXT}

Verify Unregistered Email
    Wait Until Element Is Visible    ${login_locators.email_unregistered}       ${TIME}
    Wait Until Element Is Visible    ${login_locators.email_entry}              ${TIME}
    Wait Until Element Is Visible    ${login_locators.email_confirmation}       ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_name}               ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_last_name}          ${TIME}
    Wait Until Element Is Visible    ${login_locators.select_gender}            ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_birthdate}          ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_phone}              ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_password}           ${TIME}
    Wait Until Element Is Visible    ${login_locators.password_confirmation}    ${TIME}

Click On Registration Button
    Wait Until Element Is Visible    ${login_locators.registrarse_button}          ${TIME}
    Click Element                    ${login_locators.registrarse_button}
    Wait Until Element Is Visible    ${login_locators.email_entry}              ${TIME}
    Wait Until Element Is Visible    ${login_locators.email_confirmation}       ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_name}               ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_last_name}          ${TIME}
    Wait Until Element Is Visible    ${login_locators.select_gender}            ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_birthdate}          ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_phone}              ${TIME}
    Wait Until Element Is Visible    ${login_locators.input_password}           ${TIME}
    Wait Until Element Is Visible    ${login_locators.password_confirmation}    ${TIME}

Fill Email Field
    [Arguments]    ${EMAIL}
    Wait Until Element Is Visible    ${login_locators.email_entry}              ${TIME}
    Input Text                       ${login_locators.email_entry}              ${EMAIL}

Fill Email Confirmation Field
    [Arguments]    ${EMAIL}
    Wait Until Element Is Visible    ${login_locators.email_confirmation}       ${TIME}
    Input Text                       ${login_locators.email_confirmation}       ${EMAIL}

Fill Name Field
    [Arguments]    ${NAME}
    Wait Until Element Is Visible    ${login_locators.input_name}               ${TIME}
    Input Text                       ${login_locators.input_name}               ${NAME}

Fill Last Name Field
    [Arguments]    ${LAST_NAME}    
    Wait Until Element Is Visible    ${login_locators.input_last_name}          ${TIME}
    Input Text                       ${login_locators.input_last_name}          ${LAST_NAME}

Fill Date Of Birth Field
    [Arguments]    ${DATE}
    Wait Until Element Is Visible    ${login_locators.input_birthdate}          ${TIME}
    Click Element                    ${login_locators.input_birthdate}
    Input Text                       ${login_locators.input_birthdate}          ${DATE}

Fill Phone Field
    [Arguments]    ${PHONE}
    Wait Until Element Is Visible    ${login_locators.input_phone}              ${TIME}
    Input Text                       ${login_locators.input_phone}              ${PHONE}

Fill Password Field
    [Arguments]    ${PASSWORD}    
    Wait Until Element Is Visible    ${login_locators.input_password}           ${TIME}
    Input Text                       ${login_locators.input_password}           ${PASSWORD}

Fill Password Confirmation Field
    [Arguments]    ${PASSWORD}    
    Wait Until Element Is Visible    ${login_locators.password_confirmation}    ${TIME}
    Input Text                       ${login_locators.password_confirmation}    ${PASSWORD}

Select Gender
    ${INDEX}=    Evaluate    random.randint(1, 4)    modules=random
    Select From List By Index        ${login_locators.select_gender}    ${INDEX}

Accept Terms And Conditions
    Wait Until Element Is Visible    ${login_locators.terms_conditions}          ${TIME}
    Click Element                    ${login_locators.terms_conditions}
    Checkbox Should Be Selected      ${login_locators.terms_conditions}

Click On Create Account Button
    Wait Until Element Is Visible    ${login_locators.create_account_button}     ${TIME}
    Click Element                    ${login_locators.create_account_button}

Password Incorrect Alert
    Wait Until Element Is Visible    ${login_locators.password_incorrect}        ${TIME}

Verify Registration
    Wait Until Element Is Visible    ${login_locators.registrate_final_button}    ${TIME}
    Click Element                    ${login_locators.registrate_final_button}
    Wait Until Element Is Visible    ${login_locators.confirm_email_message}      ${TIME}

Click on Forgot Password Button
    Wait Until Element Is Visible    ${login_locators.recover_password_button}     ${TIME}
    Click Element                    ${login_locators.recover_password_button}

Verify Forgot Password Page
    Wait Until Element Is Visible    ${login_locators.forgot_password_headder}     ${TIME}
    Wait Until Element Is Visible    ${login_locators.email_recovery_input}        ${TIME}
    Wait Until Element Is Visible    ${login_locators.continue_button}             ${TIME}

Click On Next Button
    Wait Until Element Is Visible    ${login_locators.continue_button}             ${TIME}
    Click Element                    ${login_locators.continue_button}

Email Not Registered Alert
    Wait Until Element Is Visible    ${login_locators.email_not_registered_alert}        ${TIME}

