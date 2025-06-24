*** Settings ***
Library    Selenium2Library
Library    Collections

Resource    ../data/platform_urls.robot

*** Variables ***
${BROWSER}
${ENVIRONMENT}

*** Keywords ***
Begin Web Test
    [Documentation]    This keyword helps set up all our test cases dynamically
    Open Browser    about:blank    ${BROWSER}    options=add_argument("--inprivate"); add_argument("--ignore-certificate-errors")
    ${URL} =    Collections.Get From Dictionary    ${PAGE}    ${ENVIRONMENT}
    Go To    ${URL}
    Maximize Browser Window

End Web Test
    [Documentation]    This keyword close the browser
    Close All Browsers
