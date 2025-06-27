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

Test Setup       Begin Web Test
Test Teardown    End Web Test

*** Variables ***
${TIME} =       20s

#To run
#robot -d results -i CHI_01 -v ENVIRONMENT:CHILANGO -v BROWSER:chrome .

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
    [Documentation]    Test LogIn page on Chilango
    [Tags]    Chilango    CHI_04
    Load Chilango Home Page
    Click on LogIn Button
    Load Login Page
