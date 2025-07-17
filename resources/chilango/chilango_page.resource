*** Settings ***
Library      Selenium2Library
Library      ../../libraries/create_xpath.py
Library      ../../libraries/download_file.py

Variables    ./chilango_locators.yaml


*** Variables ***
${TIME} =       10s
${SH_TIME} =    1s

*** Keywords ***
Load Chilango Home Page
    Wait For Condition               return document.readyState == "complete"    ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.chilango_logo}          ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.play_button}            ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.menu_modal_button}      ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.newletter_link}         ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.inicia_sesion_link}     ${TIME}

Open Search Field
    [Arguments]
    Wait For Condition           return document.readyState == "complete"            ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.principal_search_button}    ${TIME}
    Click Element                    ${chilango_locators.principal_search_button}    
    Wait Until Element Is Visible    ${chilango_locators.search_input}               ${TIME}
    Wait Until Element Is Visible    ${chilango_locators.close_search}               ${TIME}
    
Input Text, Search Button And Wait For Results
    [Arguments]    ${TEXT}    ${TITLE}
    ${XPATH} =    create_xpath.Obtain Xpath Title From Chilango    ${TITLE}
    Input Text                       ${chilango_locators.search_input}               ${TEXT}
    Wait Until Element Is Visible    ${chilango_locators.search_button2}             ${TIME}
    Click Element                    ${chilango_locators.search_button2}
    Wait Until Element Is Visible    ${XPATH}    ${TIME}
    
Select News From Search Results
    [Arguments]    ${TEXT}
    ${XPATH} =    create_xpath.Obtain Xpath Title From Chilango    ${TEXT}
    Wait Until Element Is Visible     ${XPATH}    ${TIME}
    Scroll Element Into View          ${XPATH}
    Execute JavaScript    document.body.style.zoom="60%"
    Click Element                     ${XPATH}
    Wait Until Page Contains          ${TEXT}  ${TIME}
    Scroll Element Into View          ${chilango_locators.title_news}

Close Banner If Visible
    Wait Until Element Is Visible        ${chilango_locators.close_banner}    ${TIME}
    Click Element                        ${chilango_locators.close_banner}
    Wait Until Element Is Not Visible    ${chilango_locators.close_banner}    ${TIME}

Click on LogIn Button
    Wait Until Element Is Visible   ${chilango_locators.login_button}   ${TIME}
    Click Element                   ${chilango_locators.login_button}   

Click on Minimize Radio Button
    Wait Until Element Is Visible    ${chilango_locators.minimize_button}    ${TIME}
    Click Element                    ${chilango_locators.minimize_button}
    Wait Until Element Is Visible    ${chilango_locators.maximize_button}    ${TIME}

Click on Play Radio Button
    Wait Until Element Is Visible    ${chilango_locators.play_button}     ${TIME}
    Click Element                    ${chilango_locators.play_button}
    Wait Until Element Is Visible    ${chilango_locators.pause_button}    ${TIME}

Click on Maximize Radio Button
    Wait Until Element Is Visible    ${chilango_locators.maximize_button}    ${TIME}
    Click Element                    ${chilango_locators.maximize_button}
    Wait Until Element Is Visible    ${chilango_locators.chilango_radio}     ${TIME}

Click on Mute Radio Button
    Wait Until Element Is Visible    ${chilango_locators.mute_button}      ${TIME}
    Click Element                    ${chilango_locators.mute_button}
    Wait Until Element Is Visible    ${chilango_locators.unmute_button}    ${TIME}

CLick on Newsletter Button
    Wait Until Element Is Visible    ${chilango_locators.newsletter_button}    ${TIME}
    Click Element                    ${chilango_locators.newsletter_button}

Close Search Form
    Wait Until Element Is Visible        ${chilango_locators.close_search}    ${TIME}
    Click Element                        ${chilango_locators.close_search}
    Wait Until Element Is Not Visible    ${chilango_locators.close_search}    ${TIME}

Verify Displayed Username Is Valid
    [Arguments]    ${VALID_NAME}
    Wait Until Element Is Visible    ${chilango_locators.inicia_sesion_link}    ${TIME}
    ${DISPLAYED_NAME}=    Get Text    ${chilango_locators.inicia_sesion_link}
    ${NORMALIZED}=    Evaluate    '${DISPLAYED_NAME}'.strip().lower()
    ${VALID_NORMALIZED}=    Evaluate    '${VALID_NAME}'.strip().lower() 
    Should Be Equal    ${NORMALIZED}    ${VALID_NORMALIZED}


Scroll To Element
    [Arguments]    ${XPATH}
    Wait For Condition    return document.readyState == "complete"    ${TIME}
    ${FOUND}=    Set Variable    False
    ${COUNT}=    Set Variable    0

    WHILE    '${FOUND}' == 'False' and ${COUNT} < 60
        ${FOUND}=    Run Keyword And Return Status    Page Should Contain Element    ${XPATH}
        Run Keyword If    not ${FOUND}    Execute JavaScript    window.scrollBy(0, 900)
        Run Keyword If    not ${FOUND}    Sleep    0.3s
        ${COUNT}=    Evaluate    ${COUNT} + 1
    END

    IF    not ${FOUND}
        Fail
    END

    Scroll Element Into View    ${XPATH}
    Execute JavaScript    document.body.style.zoom="90%"

Click on Magazine Julio 2025
    Wait Until Element Is Visible       ${chilango_locators.magazine_julio_2025}    ${TIME}
    Click Element                       ${chilango_locators.magazine_julio_2025}
    Wait Until Element Is Visible       ${chilango_locators.magazine_title}         ${TIME}
    Wait Until Element Is Visible       ${chilango_locators.download_mag_button}    ${TIME}
   
Click On Download Magazine
    Wait Until Element Is Visible    ${chilango_locators.download_mag_button}    ${TIME}
    Click Element                    ${chilango_locators.download_mag_button}

Verify Download
    [Arguments]     ${DOWNLOAD_DIR}
    Sleep    5s
    ${archivo}=    Wait For Any Download    ${DOWNLOAD_DIR}    timeout=30    min_size_kb=10
    Log    Se descargó un archivo: ${archivo}

Chilango Year and Registered Brand
    [Arguments]    
    ${FULL_DATE}=    Get Time
    ${FULL_DATE_STR}=    Convert To String    ${FULL_DATE}
    ${YEAR}=    Evaluate    ${FULL_DATE_STR}[:4]
    Page Should Contain    ${YEAR} Derechos Reservados
    Page Should Contain    Chilango es una marca registrado de Capital Digital.