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
    [Arguments]    ${text}
    Wait For Condition           return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.principal_search_button}    ${TIME}
    Click Element    ${chilango_locators.principal_search_button}    
    Wait Until Element Is Visible   ${chilango_locators.search_input}    ${TIME}
    Input Text    ${chilango_locators.search_input}                      ${text}

Click Search Button And Wait For Results
    [Arguments]    ${text}
    Click Element    ${chilango_locators.search_button2}
    Wait Until Page Contains    ${text}    timeout=${TIME}

Select News From Search Results
    [Arguments]    ${text}
    Wait Until Element Is Visible     ${chilango_locators.tim_burton_news_link}    ${TIME}
    Scroll Element Into View          ${chilango_locators.tim_burton_news_link}
    Click Element                     ${chilango_locators.tim_burton_news_link}
    Wait Until Page Contains          ${text}  ${TIME}   

Close Banner If Visible
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${chilango_locators.close_banner}    ${TIME}
    Run Keyword And Ignore Error    Click Element                    ${chilango_locators.close_banner}
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible    ${chilango_locators.close_banner}    ${TIME}

LogIn Page
    Wait Until Element Is Visible   ${chilango_locators.login_button}   ${TIME}
    Click Element    ${chilango_locators.login_button}   
    Wait Until Element Is Visible    locator=//a[contains(text(), "Registrate")]