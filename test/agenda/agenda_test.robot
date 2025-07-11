*** Settings ***
Documentation    Agenda Test Suite
...    Agenda home page -> https://www.chilango.com/agenda/

Library      Selenium2Library
Library      Collections
Library      ../../libraries/create_xpath.py

Resource     ../../data/credential_user.robot
Resource     ../../data/platform_urls.robot
Resource     ../../resources/agenda/agenda_page.resource
Resource    ../../resources/common_web.resource


Test Setup       Begin Web Test    ${TEST_DATA_PATH}
Test Teardown    End Web Test

*** Variables ***
${TEST_DATA_PATH} =    agenda
${LONG_TIME} =         20
${ToAgenda} =          navbar-toggler-icon
#To run
#robot -d results -i AGN_01 -v ENVIRONMENT:AGENDA -v REPORT:FALSE -v BROWSER:chrome .

*** Test Cases ***
AGN_01 - Agenda Home Page Is Loaded
    [Documentation]    Test Agenda home page is loaded correctly
    [Tags]    Agenda    AGN_01
    Load Agenda Home Page

AGN_02 - Search Jazz In Agenda Page
    [Documentation]    Test the search Button and the search action to find jazz events on the agenda page
    [Tags]    Agenda    AGN_02
    ${VAR1} =    Set Variable    Jazz
    ${VAR2} =    Set Variable    We call it Jazz: Un Viaje al Corazón de Nueva Orleans
    Load Agenda Home Page
    Click On search Event And Search An Event    ${VAR1}
    Click On Event    ${VAR2}
    Wait A Is Visible    Comprar boleto

AGN_03 - Click In More Events Until no More Events Loaded
    [Documentation]    Clicks the "Mas eventos"'s Button Until the Button is not Visible
    [Tags]    Agenda    AGN_03
    Load Chilango Home Page
    Click Span Class In Page     navbar-toggler-icon
    Wait Image Visible     Agenda
    Click Image In Page    Agenda
    Switch From Chilango To Agenda Page
    Load Agenda Home Page
    Click On Button Until Is Not Visible    Mostrar más eventos 

AGN_04 - Agenda Page From Chilango Page
    [Documentation]    Goes from chilango main page to agenda a secundary page
    [Tags]    Agenda    AGN_04
    Load Chilango Home Page
    Click Span Class In Page     navbar-toggler-icon
    Wait Image Visible     Agenda
    Click Image In Page    Agenda
    Switch From Chilango To Agenda Page
    Load Agenda Home Page

AGN_05 - Click On Category And Validates Color Change
    [Documentation]    Selects a category and validates the color of that category
    [Tags]    Agenda    AGN_05
    Load Agenda Home Page
    Click Span Name In Page    Música
    Validates Span In Button Visible    (2)

AGN_06 - Click On Category And Validates Sub Categories
    [Documentation]    Selects a category and validates the sub categories appears
    [Tags]    Agenda    AGN_06
    Load Agenda Home Page
    Click Span Name In Page    Música
    Validates Span Contains In Page    (2) 

AGN_07 - Validates Recomendation Message
    [Documentation]    Validates the appears of the pop up help message
    [Tags]    Agenda    AGN_07
    Load Agenda Home Page
    Validates P Object Present    ¿Buscas un plan con niños, en pareja o con amigos?

AGN_08 - Validates Slide Filter Option
    [Documentation]    Validates the appears of the slide filter Option
    [Tags]    Agenda    AGN_08
    Load Agenda Home Page
    Click Button Class In Page    md:inline-flex hidden items-center justify-center cursor-pointer
    Validates Button Visible    Con amigos

AGN_09 - Validates Event Day Color Change In Event Calendar
    [Documentation]    Validates the change of the color after the selection of a arbitrary number in calendario_button_agenda
    [Tags]    Agenda    AGN_09
    Load Agenda Home Page
    Click On search Event And Search An Event    El Rey León
    Click On Event    El Rey León
    Wait A Is Visible    Comprar boleto

AGN_10 - From Chilango To Agenda And Click On Termns And Conditions
    [Documentation]    From chilango page opens agenda page and click on termns and conditions and waits until important elements are Visible
    [Tags]    Agenda    AGN_10
    ${VAR} =    Set Variable    Agenda
    Load Chilango Home Page
    Click Span Class In Page     ${ToAgenda}
    Wait Image Visible     ${VAR}
    Click Image In Page    ${VAR}
    Switch From Chilango To Agenda Page
    Load Agenda Home Page
    Click A Footer Sub    Términos y condiciones
    Switch From Agenda To Termns And Conditions
    Load Terminos y Condiciones Page    NEWSLETTER    Inicia Sesión    Chilango - Te decimos qué hacer en la Ciudad de México
