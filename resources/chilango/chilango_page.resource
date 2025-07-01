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
    Wait Until Element Is Visible    ${chilango_locators.play_button}            ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.menu_modal_button}      ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.newletter_link}         ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.inicia_sesion_link}     ${TIME}

Input Text In Search Field
    [Arguments]    ${TEXT}
    Wait For Condition           return document.readyState == "complete"            ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.principal_search_button}    ${TIME}
    Click Element                    ${chilango_locators.principal_search_button}    
    Wait Until Element Is Visible    ${chilango_locators.search_input}               ${TIME}
    Input Text                       ${chilango_locators.search_input}               ${TEXT}

Click Search Button And Wait For Results
    [Arguments]    ${TEXT}    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Title From Chilango    ${TITLE}
    Wait Until Element Is Visible    ${chilango_locators.search_button2}    ${TIME}
    Click Element                    ${chilango_locators.search_button2}
    Wait Until Element Is Visible    ${XPATH}    ${TIME}
    
Select News From Search Results
    [Arguments]    ${TEXT}
    ${XPATH} =    create_xpath.Obtain Xpath Title From Chilango    ${TEXT}
    Wait Until Element Is Visible     ${XPATH}    ${TIME}
    Scroll Element Into View          ${XPATH}
    Execute JavaScript    document.body.style.zoom="60%"
    Click Element                     ${XPATH}
    Wait Until Page Contains          ${TEXT}  ${TIME}
    Scroll Element Into View          ${chilango_locators.title_news}

Close Banner If Visible
    Wait Until Element Is Visible        ${chilango_locators.close_banner}   ${TIME}
    Click Element                        ${chilango_locators.close_banner}
    Wait Until Element Is Not Visible    ${chilango_locators.close_banner}    ${TIME}

Click on LogIn Button
    Wait Until Element Is Visible   ${chilango_locators.login_button}   ${TIME}
    Click Element                   ${chilango_locators.login_button}   

Click on Minimize Radio Button
    Wait Until Element Is Visible    ${chilango_locators.minimize_button}    ${TIME}
    Click Element                    ${chilango_locators.minimize_button}

Click on Play Radio Button
    Wait Until Element Is Visible    ${chilango_locators.play_button}    ${TIME}
    Click Element                    ${chilango_locators.play_button}
    Wait Until Element Is Visible    ${chilango_locators.pause_button}    ${TIME}

Click on Maximize Radio Button
    Wait Until Element Is Visible    ${chilango_locators.maximize_button}    ${TIME}
    Click Element                    ${chilango_locators.maximize_button}
    Wait Until Element Is Visible    ${chilango_locators.chilango_radio}    ${TIME}

Click on Mute Radio Button
    Wait Until Element Is Visible    ${chilango_locators.mute_button}    ${TIME}
    Click Element                    ${chilango_locators.mute_button}
    Wait Until Element Is Visible    ${chilango_locators.unmute_button}    ${TIME}