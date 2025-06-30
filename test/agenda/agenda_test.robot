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
    Load Agenda Home Page
    Click On search Event And Search An Event    Jazz
    Click On Event Found    We call it Jazz: Un Viaje al Corazón de Nueva Orleans
    Sleep    10

AGN_03 - Click In More Events Until no More Events Loaded
    [Documentation]    Clicks the "Mas eventos"'s Button Until the Button is not Visible
    [Tags]    Agenda    AGN_03
    Load Agenda Home Page
    Click On Button Until Is Not Visible
    Sleep    10    

AGN_04 - Agenda Page From Chilango Page
    [Documentation]    Goes from chilango main page to agenda a secundary page
    [Tags]    Agenda    AGN_04
    Load Chilango Home Page
    Click Span In Page     navbar-toggler-icon
    Wait Image Visible     Agenda
    Click Image In Page    Agenda
    Load Agenda Home Page
    Sleep    10

AGN_05 - Click On Category And Validates Color Change
    [Documentation]    Selects a category and validates the color asked
    [Tags]    Agenda    AGN_05
    Sleep    10

AGN_06 - Click On Category And Validates Sub Categories
    [Documentation]    Selects a category and validates the sub categries appears
    [Tags]    Agenda    AGN_06
    Sleep    10

AGN_07 - Validates Recomendation Message
    [Documentation]    Validates the appears of the pop up help message
    [Tags]    Agenda    AGN_07
    Sleep    10

AGN_08 - Validates Slide Filter Option
    [Documentation]    Validates the appears of the slide filter Option
    [Tags]    Agenda    AGN_08
    Sleep    10

AGN_09 - Validates Event Day Color Change In Event Calendar
    [Documentation]    Validates the change of the color after the selection of a arbitrary number in calendario_button_agenda
    [Tags]    Agenda    AGN_09    
    Sleep    10
    