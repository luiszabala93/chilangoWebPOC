*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Variables    ./newsletter_locators.yaml

*** Variables ***
${TIME} =       10s
${SH_TIME} =    1s


*** Keywords ***
Load Newsletter Page
    Wait For Condition               return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible    ${newsletter_locators.newsletter_title}       ${TIME}
    Wait Until Element Is Visible    ${newsletter_locators.email_input}             ${TIME}
    Wait Until Element Is Visible    ${newsletter_locators.submit_button}           ${TIME}
    Wait Until Element Is Visible    ${newsletter_locators.chilango_logo}            ${TIME}