*** Settings ***
Library     Selenium2Library
Library     ScreenCapLibrary
Library     Collections
Library     String
Library     OperatingSystem
Library     ../libraries/remove_files.py

Resource    ../data/platform_urls.robot

*** Variables ***
${BROWSER} =    chrome
${ENVIRONMENT}
${REPORT} =     FALSE

*** Keywords ***
Begin Web Test
    [Documentation]    This keyword helps set up all our test cases dynamically
    [Arguments]    ${TEST_PATH}
    ${PATH} =      Set Variable    ${TEST_PATH}
    ${NAME} =      Set Variable    ${TEST TAGS}[0]
    Create Directory    results/videos/${PATH}
    Open Browser    about:blank    ${BROWSER}    options=add_argument("--inprivate"); add_argument("--ignore-certificate-errors")
    remove_files.Remove Files
    Set Selenium Speed    0.1s
    IF  '${REPORT}'.lower() == 'true' 
        Start video recording    name=videos/${PATH}/${NAME}
    ELSE
        Log   Video recording is disabled
    END
    ${URL} =    Collections.Get From Dictionary    ${PAGE}    ${ENVIRONMENT}
    Go To    ${URL}
    Maximize Browser Window
   
End Web Test
    [Documentation]    This keyword close the browser
    ${NAME} =    Set Variable    ${TEST TAGS}[0]
    ${ENVI} =    Set Variable    ${ENVIRONMENT}
    ${FAILED_PATH} =    Set Variable    results/failed/${ENVI}/${NAME}
    Run keyword If Test Failed    Run Keywords
    ...    Selenium2Library.Set Screenshot Directory    ${FAILED_PATH}    AND
    ...    Capture Page Screenshot
    IF  '${REPORT}'.lower() == 'true' 
        Stop video recording
    ELSE
        Log   Video recording is disabled
    END
    Close All Browsers
