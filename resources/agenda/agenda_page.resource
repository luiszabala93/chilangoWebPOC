*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Variables    ./agenda_locators.yaml

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

Click On Search Event And Search An Event
    [Arguments]    ${TEXT}
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.search_input_agenda}          ${TIME}
    Click Element                    ${agenda_locators.search_input_agenda}
    Input Text                       ${agenda_locators.search_input_agenda}          ${TEXT}
    Press Keys                       ${agenda_locators.search_input_agenda}          ENTER

Click On Event Found
    [Arguments]    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Image    ${TITLE}
    Wait Until Element Is Visible    ${XPATH}        ${TIME}
    Click Element                    ${XPATH}

Click On More Events Until Is Not Visible
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.search_input_agenda}          ${TIME}
    click Element                    ${agenda_locators.mostrar_mas_eventos_button}

Click Event And Wait For Calendar
    Wait For Condition               return document.readyState == "complete"        ${TIME}
    Wait Until Element Is Visible    ${agenda_locators.search_input_agenda}
    Click Element                    ${agenda_locators.Imagen_evento}
    Wait Until Element Is Visible    ${agenda_locators.comprar_boleto_button}