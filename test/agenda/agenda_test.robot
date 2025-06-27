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
    Click On More Events Until Is Not Visible

AGN_04 - Click An Event And Wait A Page to Load
    [Documentation]    Click an event's image and waits Until the event's calendar appears
    [Tags]    Agenda    AGN_04
    Click Event And Wait For Calendar