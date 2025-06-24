*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Variables    ./chilango_locators.yaml

*** Variables ***
${TIME} =       10s
${SH_TIME} =    1s
${ENVIRONMENT}

*** Keywords ***
Load Chilango Home Page
    Wait For Condition               return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.chilango_logo}          ${TIME}
    Wait Until Element Is Enabled    ${chilango_locators.play_button}            ${TIME}
    Wait Until Element Is Enabled    ${chilango_locators.menu_modal_button}      ${TIME}
    Wait Until Element Is Enabled    ${chilango_locators.newletter_link}         ${TIME}
    Wait Until Element Is Enabled    ${chilango_locators.inicia_sesion_link}     ${TIME}
