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
#robot -d results -i AGN_01 -v ENVIRONMENT:AGENDA -v BROWSER:chrome .

*** Test Cases ***
AGN_01 - Agenda Home Page Is Loaded
    [Documentation]    Test Agenda home page is loaded correctly
    [Tags]    Agenda    AGN_01
    Load Agenda Home Page
