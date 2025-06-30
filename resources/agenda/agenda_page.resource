*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Variables    ./agenda_locators.yaml
Variables    ../../resources/chilango/chilango_locators.yaml

*** Variables ***
${TIME} =       10s
${SH_TIME} =    1s
${ENVIRONMENT}

*** Keywords ***
Load Agenda Home Page
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.search_input_agenda}          ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.inicia_sesion_link_agenda}    ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.musica_button_agenda}         ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.teatro_button_agenda}         ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.calendario_button_agenda}     ${TIME}

Load Chilango Home Page
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.chilango_logo}              ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.play_button}                ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.menu_modal_button}          ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.newletter_link}             ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.inicia_sesion_link}         ${TIME}

Click On Search Event And Search An Event
    [Arguments]    ${TEXT}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.search_input_agenda}          ${TIME}
    Click Element                    ${agenda_locators.search_input_agenda}
    Input Text                       ${agenda_locators.search_input_agenda}          ${TEXT}
    Press Keys                       ${agenda_locators.search_input_agenda}          ENTER

Click On Event Found
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Image     ${TITLE}
    Wait Until Element Is Visible    ${XPATH}         ${TIME}
    Click Element                    ${XPATH}

Click On Button Until Is Not Visible
    [Arguments]    ${TITLE}
    ${i} =     Set Variable    0
    ${XPATH} =    create_xpath.Obtain Xpath Button    ${TITLE}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${XPATH}         ${TIME}                                   
    WHILE    ${i} = 0
        ${COMO} =     Run Keyword And Ignore Error    Click Element    ${XPATH}
        IF     ${COMO} = 'FAIL'
                ${i} =      Set Variable    1
        END
    END
    ${COMO}[0]


Click Image In Page
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Image    ${TITLE}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${XPATH}
    Click Element                    ${XPATH}    

Click Button In Page
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Button    ${TITLE}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${XPATH}
    Click Element                    ${XPATH}   

Click Span In Page
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Span    ${TITLE}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${XPATH}
    Click Element                    ${XPATH}   

Wait Image Visible
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Image    ${TITLE}
    Wait Until Element Is Visible    &{XPATH}