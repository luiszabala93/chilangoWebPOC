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
    Wait Until Element Is Enabled    ${agenda_locators.inicia_sesion_link_agenda}    ${TIME}
    Wait Until Element Is Enabled    ${agenda_locators.musica_button_agenda}         ${TIME}
    Wait Until Element Is Enabled    ${agenda_locators.teatro_button_agenda}         ${TIME}
    Wait Until Element Is Enabled    ${agenda_locators.calendario_button_agenda}     ${TIME}

click On Search Event And Search An Event
    wait For Condition               return document.readyState == "complete"        ${TIME}
    wait Until Element Is Visible    ${agenda_locators.search_input_agenda}
    Click Element                    ${agenda_locators.search_input_agenda}
    Input Text                       ${text}
    Press Key                        ${key}
    wait Until Element Is Visible    ${agenda_locators.Imagen_jazz}
    Click Element                    ${agenda_locators.Imagen_jazz}

Click On More Events Until Is Not Visible
    wait For Condition               return document.readyState == "complete"        ${TIME}
    wait Until Element Is Visible    ${agenda_locators.search_input_agenda}
    click Element                    ${agenda_locators.mostrar_mas_eventos_button}

Click Event And Wait For Calendar
    wait For Condition               return document.readyState == "complete"        ${TIME}
    wait Until Element Is Visible    ${agenda_locators.search_input_agenda}
    Click Element                    ${agenda_locators.Imagen_evento}
    wait Until Element Is Visible    ${agenda_locators.comprar_boleto_button}