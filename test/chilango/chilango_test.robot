*** Settings ***
Documentation    Chilango Test Suite
...    Chilango home page -> https://www.chilango.com/

Library      Selenium2Library
Library      Collections
Library      ../../libraries/create_xpath.py

Resource     ../../data/credential_user.robot
Resource     ../../data/platform_urls.robot
Resource     ../../resources/chilango/chilango_page.resource
Resource     ../../resources/common_web.resource
Resource     ../../resources/chilango/login_page.resource

Test Setup       Begin Web Test    ${TEST_DATA_PATH}
Test Teardown    End Web Test

*** Variables ***
${TEST_DATA_PATH} =    chilango
${LONG_TIME} =         20

#To run
#robot -d results -i CHI_01 -v ENVIRONMENT:CHILANGO -v REPORT:FALSE -v BROWSER:chrome .

*** Test Cases ***
CHI_01 - Chilango Home Page Is Loaded
    [Documentation]    Test Chilango home page is loaded correctly
    [Tags]    Chilango    CHI_01
    Load Chilango Home Page

CHI_02 - Search Tim Burton's "Laberinto en CDMX" news on Chilango
    [Documentation]    Test search for Tim Burton's "Laberinto en CDMX" news on Chilango
    [Tags]    Chilango    CHI_02
    ${TEXT1} =    Set Variable    Tim Burton
    ${TITLE} =    Set Variable    Tim Burton Laberinto en CDMX
    Load Chilango Home Page
    Input Text In Search Field    ${TEXT1}
    Click Search Button And Wait For Results    ${TEXT1}    ${TITLE}
    Select News From Search Results    ${TITLE}

CHI_03 - Close Banner
    [Documentation]    Test close banner on Chilango home page
    [Tags]    Chilango    CHI_03
    Load Chilango Home Page
    Close Banner If Visible

CHI_04 - LogIn Page
    [Documentation]    Positive Test Case:
    ...    This test case verify that login page is loaded successfully
    ...    Expected results: The page should load successfully
    [Tags]    Chilango    CHI_04
    Load Chilango Home Page
    Click on LogIn Button
    Load Login Page

CHI_05 - Play Chilango Radio and Verufy
    [Documentation]    Positive Test Case:
    ...    This test case verify that Chilango Radio is played successfully
    ...    Expected results: The radio should play successfully
    [Tags]    Chilango    CHI_05
    Load Chilango Home Page
    Click on Play Radio Button 

CH_06 - Minimize and Maximize Chilango Radio
    [Documentation]    Positive Test Case:
    ...    This test case verify that Chilango Radio can be minimized and maximized successfully
    ...    Expected results: The radio should minimize and maximize successfully
    [Tags]    Chilango    CHI_06
    Load Chilango Home Page
    Click on Minimize Radio Button
    Click on Maximize Radio Button

CHI_07 - Mute Chilango Radio
    [Documentation]    Positive Test Case:
    ...    This test case verify that Chilango Radio can be muted successfully
    ...    Expected results: The radio should mute successfully
    [Tags]    Chilango    CHI_07
    Load Chilango Home Page
    Click on Mute Radio Button

CHI 08 - @ Missing In The Mail
    [Documentation]    Positive Test Case:
    ...    This test case verify that the Chilango page is loaded successfully
    ...    Expected results: The page should load successfully
    [Tags]    Chilango    CHI_08
    ${MAIL} =    Set Variable    angygmail.com
    Load Chilango Home Page
    Click on LogIn Button
    Load Login Page
    Input Text In Email Field    ${MAIL}
    Click on Login Button Inside The Login Page
    Location Should Be           ${PAGE.LOGIN}
