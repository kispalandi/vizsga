*** Settings ***
Resource    ../resources/common_resources.resource
Library    OperatingSystem

*** Variables ***
${URL}    https://bwpool.azurewebsites.net/   
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${USER_DATA_API}    https://random-data-api.com/api/users/random_user?size=1
${SESSION_NAME}    API Session

*** Keywords ***
Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

Test Teardown
    Close All Browsers

Navigate To Customer Menu
    [Arguments]    ${menu_url}
    Go To    ${menu_url}
    Click Element    ${CUSTOMER_MENU}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}

*** Test Cases ***
Navigate To Customer Menu
    Open Browser To Login Page
    Navigate To Customer Menu    ${URL}/Customer

Api Call Test
    Create Session    ${SESSION_NAME}    ${USER_DATA_API}
    ${response}    Get On Session    ${SESSION_NAME}    ${USER_DATA_API}
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}    Set Variable    ${response.json()}
    
    Log    ${body}

    ${first_name}    Set Variable    ${body}[0][first_name]
    ${last_name}    Set Variable    ${body}[0][last_name]
    ${email}    Set Variable    ${body}[0][email]
    ${id}    Set Variable    ${body}[0][id]

    Click Button    ${ADD_BUTTON}

    Wait Until Element Is Visible    ${CUSTOMER_NAME}    timeout=10s

    Input Text    ${CUSTOMER_NAME}    ${first_name} ${last_name}
    Input Text    ${E-MAIL_FIELD}    ${email}
    Input Text    ${COMMENT}    ${id}

    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}    timeout=10s
	