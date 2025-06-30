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