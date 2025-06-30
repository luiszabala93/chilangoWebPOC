*** Settings ***
Library    Selenium2Library
Library    Collections
Library    String
Library    ../libraries/pdf_report_code.py

Resource    ../data/platform_urls.robot

*** Variables ***
${BROWSER}
${BROWSER_NAV}
${ENVIRONMENT}
${TEST_DATA_PATH}
${REPORT}

*** Keywords ***
Begin Web Test
    [Documentation]    This keyword helps set up all our test cases dynamically
    [Arguments]    ${TEST_PATH}    ${BROWSER_NAME}=True
    Prepare Environment    ${TEST_PATH}    ${BROWSER_NAME}
    Open Browser    about:blank    ${BROWSER}    options=add_argument("--inprivate"); add_argument("--ignore-certificate-errors")
    ${URL} =    Collections.Get From Dictionary    ${PAGE}    ${ENVIRONMENT}
    Go To    ${URL}
    Maximize Browser Window
   # Set Selenium Speed    0.5s

End Web Test
    [Documentation]    This keyword close the browser
    ${FAILED_PATH} =     pdf_report_code.Get Failed Evidence Path 
    Run Keyword If Test Failed    Run Keywords
    ...    pdf_report_code.Remove Tc Directory Temporary Files    AND
    ...    pdf_report_code.Save Evidence If Test Failed    AND
    ...    Selenium2Library.Set Screenshot Directory    ${FAILED_PATH}    AND
    ...    Capture Page Screenshot
    Close All Browsers
    Run Keyword If Test Passed    Run Keywords
    ...    Create Pdf Report
    ...    pdf_report_code.Remove Tc Directory Temporary Files

Prepare Environment
    [Arguments]    ${TEST_PATH}    ${BROWSER_NAME}
    IF    'Env:${ENVIRONMENT}'=='Env:'
        Set Suite Variable    ${ENVIRONMENT}    INT
    END
    IF    'Browser:${BROWSER}'=='Browser:'
        Set Suite Variable    ${BROWSER}    chrome
    END
    IF    ${BROWSER_NAME}
        Get Current Browser
    END
    IF    'Rep:${REPORT}' != 'Rep:'
        ${REPORT} =    String.Convert To_Upper Case    ${REPORT}
        set suite variable    ${REPORT}    ${REPORT}
    END
    ${REPORTS} =    pdf_report_code.Get Reports Directory Path
    ${SUBFOLDERS} =    String.Split String    ${TEST_DATA_PATH}    \\
    pdf_report_code.Set Global Environment    ${ENVIRONMENT}
    pdf_report_code.Create Report Directory On Results Folder    ${REPORTS}    ${SUBFOLDERS}
    pdf_report_code.Set Test Name    ${TEST_NAME}
    pdf_report_code.Set Browser Name    ${BROWSER_NAV}
    Set Suite Variable    ${TEST_DATA_PATH}    ${TEST_PATH}
    ${SCREENSHOT_DIRECTORY} =    pdf_report_code.Get Screenshots Path
    Selenium2Library.Set Screenshot Directory    ${SCREENSHOT_DIRECTORY}

Get Current Browser
    Run Keyword If    "${BROWSER}" == "edge"      set suite variable    ${BROWSER_NAV}    Microsoft Edge
    Run Keyword If    "${BROWSER}" == "chrome"    set suite variable    ${BROWSER_NAV}    Google Chrome
    Run Keyword If    "${BROWSER}" == "ff"        set suite variable    ${BROWSER_NAV}    Mozilla Firefox
    Run Keyword If    "${BROWSER}" == "ie"        set suite variable    ${BROWSER_NAV}    Internet Explorer
    Run Keyword If    "${BROWSER}" == "opera"     set suite variable    ${BROWSER_NAV}    Opera

Check Browser Before Screenshot
    Run Keyword If    "${BROWSER_NAV}" != "Mozilla Firefox"    execute javascript    document.body.style.zoom="60%"
    Run Keyword If    "${BROWSER_NAV}" == "Mozilla Firefox"    execute javascript    document.body.style.MozTransform = "scale(0.4)"

Check Browser After Screenshot
    Run Keyword If    "${BROWSER_NAV}" != "Mozilla Firefox"    execute javascript    document.body.style.zoom="100%"
    Run Keyword If    "${BROWSER_NAV}" == "Mozilla Firefox"    execute javascript    document.body.style.MozTransform = "scale(1)"

Create Pdf Report
    IF    '${REPORT}' == 'TRUE'
        pdf_report_code.pdf_configuration_setup    ${TEST_DATA_PATH}    ${TEST_NAME}
        Set Test Message      ${TEST_DATA_PATH}
        Set Test Message      ${TEST_NAME}
        ${CODE} =    pdf_report_code.get_test_code
        ${RESULTS} =    pdf_report_code.get results directory path
        ${TEST_INFO} =    pdf_report_code.get_test_information    ${TEST_DATA_PATH}    ${TEST_NAME}
        pdf_report_code.write_test_documentation    ${TEST_INFO}    ${RESULTS}    ${TEST_NAME}
        pdf_report_code.create report    ${TEST_DATA_PATH}    ${TEST_NAME}    ${ENVIRONMENT}    ${BROWSER_NAV}
    END

Get evidence
    [Arguments]    ${TIME_SLEEP}=0    ${ZOOM}=True
    IF    'Rep:${REPORT}' != 'Rep:'
        Sleep    ${TIME_SLEEP}
        Run Keyword If    '${ZOOM}'=='True'    Check Browser Before Screenshot
        ${NAME} =    pdf_report_code.Get Current Image Name
        Capture Page Screenshot    ${NAME}.png
        Run Keyword If    '${ZOOM}'=='True'    Check Browser After Screenshot
    END
