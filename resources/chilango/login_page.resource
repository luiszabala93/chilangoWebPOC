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

Click on Register Button
    Wait Until Element Is Visible    ${login_locators.label_registrate}          ${TIME}
    Click Element                    ${login_locators.label_registrate}
    Wait Until Page Contains         "Registrate"                               ${TIME}