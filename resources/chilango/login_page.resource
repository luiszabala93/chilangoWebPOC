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
    Wait Until Element Is Visible    ${login_locators.login_button_Inside}          ${TIME}
    Click Element                    ${login_locators.login_button_Inside}