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

#To run
#robot -d results -i CHI_01 -v ENVIRONMENT:CHILANGO -v BROWSER:chrome .

*** Test Cases ***
CHI_01 - Chilango Home Page Is Loaded
    [Documentation]    Test Chilango home page is loaded correctly
    [Tags]    Chilango    CHI_01
    Load Chilango Login Page
