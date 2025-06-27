*** Settings ***
Documentation    Chilango Test Suite
...    Chilango home page -> https://www.chilango.com/

Library      Selenium2Library
Library      Collections
Library      ../../libraries/create_xpath.py

Resource     ../../data/credential_user.robot
Resource     ../../data/platform_urls.robot
Resource     ../../resources/chilango/chilango_page.resource
Resource    ../../resources/common_web.resource


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
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    Input Text In Search Field    Tim Burton
    Click Search Button And Wait For Results    Tim Burton
    Select News From Search Results    Tim Burton Laberinto en CDMX
    Scroll Element Into View    locator=//h1[@class="entry-title"]

CHI_03 - Close Banner
    [Documentation]    Test close banner on Chilango home page
    [Tags]    Chilango    CHI_03
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    Close Banner If Visible

CHI_04 - LogIn Page
    [Documentation]    Test LogIn page on Chilango
    [Tags]    Chilango    CHI_04
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    LogIn Page

    


