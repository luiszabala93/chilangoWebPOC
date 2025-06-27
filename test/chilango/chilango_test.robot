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
    Wait Until Element Is Visible    ${chilango_locators.principal_search_button}    ${TIME}
    Click Element    ${chilango_locators.principal_search_button}    
    Wait Until Element Is Visible   ${chilango_locators.search_input}    ${TIME}
    Input Text    ${chilango_locators.search_input}    Tim Burton
    Click Element    ${chilango_locators.search_button2}
    Wait Until Page Contains    Tim Burton    timeout=${TIME}
    Wait Until Element Is Visible     ${chilango_locators.tim_burton_news_link}    ${TIME}
    Scroll Element Into View          ${chilango_locators.tim_burton_news_link}
    Click Element                    ${chilango_locators.tim_burton_news_link}
    Wait Until Page Contains          Tim Burton Laberinto en CDMX    ${TIME}
    Scroll Element Into View    locator=//h1[@class="entry-title"]

CHI_03 - Close Banner
    [Documentation]    Test close banner on Chilango home page
    [Tags]    Chilango    CHI_03
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.close_banner}    ${TIME}
    Click Element    ${chilango_locators.close_banner}
    Wait Until Element Is Not Visible    ${chilango_locators.close_banner}    ${TIME}

CHI_04 - LogIn Page
    [Documentation]    Test LogIn page on Chilango
    [Tags]    Chilango    CHI_04
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible   ${chilango_locators.login_button}   ${TIME}
    Click Element    ${chilango_locators.login_button}   
    Wait Until Element Is Visible    locator=//a[contains(text(), "Registrate")]


    


