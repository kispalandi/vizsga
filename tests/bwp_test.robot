*** Settings ***
Resource    ../resources/common_resources.resource
Library    OperatingSystem

*** Variables ***
${URL}    https://bwpool.azurewebsites.net/   
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${USER_DATA_API}    https://random-data-api.com/api/users/random_user?size=1
${SESSION_NAME}    API1 Session
${DEVICE_DATA_API}    https://random-data-api.com/api/device/random_device?size=2

*** Keywords ***
Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

Test Teardown
    Close All Browsers

# Navigate To Customer Menu
    Go To    ${URL}/Customer
    Click Element    ${CUSTOMER_MENU}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}

# Navigate To Locations Menu
    Go To    ${URL}/Location
    Click Element    ${LOCATIONS_MENU}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}      

    # [Arguments]    ${customer_name}    ${city}    ${zip_code}    ${street_name}    ${street_address}

*** Test Cases ***
# Navigate To Customer Menu
    # Open Browser To Login Page
    # Navigate To Customer Menu

Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

# Open Customer Menu
    Click Element    ${CUSTOMER_MENU}
    # Sleep    5s    ${CUSTOMER_GRID}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}

# Api Call Test
    Create Session    ${SESSION_NAME}    ${USER_DATA_API}
    ${response}    Get On Session    ${SESSION_NAME}    ${USER_DATA_API}
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}    Set Variable    ${response.json()}
    
    Log    ${body}

    ${first_name}    Set Variable    ${body}[0][first_name]
    ${last_name}    Set Variable    ${body}[0][last_name]
    ${email}    Set Variable    ${body}[0][email]
    ${id}    Set Variable    ${body}[0][id]
    ${city}    Set Variable    ${body}[0][address][city]
    ${zip_code}    Set Variable    ${body}[0][address][zip_code]
    ${street_name}    Set Variable    ${body}[0][address][street_name]
    ${street_address}    Set Variable    ${body}[0][address][street_address]

    Wait Until Element Is Enabled    ${ADD_BUTTON}    timeout=10s
    Sleep    2s
    Click Button    ${ADD_BUTTON}

    Wait Until Element Is Visible    ${CUSTOMER_NAME}    timeout=10s

    Input Text    ${CUSTOMER_NAME}    ${first_name} ${last_name}
    Input Text    ${E-MAIL_FIELD}    ${email}
    Input Text    ${COMMENT}    ${id}

    # Wait Until Element Is Visible    ${CUSTOMER_MENU}
    # Click Element    ${CUSTOMER_MENU}
    # Sleep    2s    
    # Wait Until Element Is Visible    ${CUSTOMER_GRID}

    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}    timeout=10s

# Fill Customer Location Form
    Open Location Menu
    Wait Until Element Is Enabled     ${ADD_BUTTON}
    Sleep    2s
    Click Button    ${ADD_BUTTON}    # Kattintás az űrlap hozzáadás gombjára
    Wait Until Element Is Visible    ${LOCATION_CUSTOMER}    timeout=10s    # Várakozás az ügyfél legördülő menü megjelenésére
    Click Element    ${LOCATION_CUSTOMER_DROPDOWN}
    # Select From List By Label    ${LOCATION_CUSTOMER_DROPDOWN}    ${customer_name}    # Ügyfél kiválasztása a legördülő menüből
    Input Text    ${LOCATION_CUSTOMER}    ${first_name} ${last_name}
    Input Text    ${CITY}    ${city}    # Város megadása
    Input Text    ${ZIP_CODE}    ${zip_code}    # Irányítószám megadása
    Input Text    ${STREET_NAME}    ${street_name}    # Utcanév megadása
    Input Text    ${STREET_ADDRESS}    ${street_address}    # Házszám megadása
    Click Button    ${SAVE_BUTTON}    # Űrlap mentése
    Wait Until Element Is Visible    ${LOCATIONS_GRID}    timeout=10s    # Várakozás a telephelyek táblázat megjelenésére

# Device Api Call Test
    # GET Json response from URL and save the Json body into the ${body} variable
    ${response}    GET    https://random-data-api.com/api/device/random_device    params=size=2
    ${body}    Set Variable    ${response.json()}
    
    # Log the Json body out (DEBUG CONSOLE)
    Log    ${body}

    # Extract id from ${body} (it's a dictionary)
    ${id}    Set Variable    ${body}[0][id]
    Log    ${id}
    
    # Extract first_name from ${body} (it's a dictionary)
    ${manufacturer}    Set Variable    ${body}[0][manufacturer]
    Log    ${manufacturer}

    # Extract last_name from ${body} (it's a dictionary)
    ${model}    Set Variable    ${body}[0][model]
    Log    ${model}
    
    # Extract zip_code from ${body} (it's a dictionary)
    ${platform}    Set Variable    ${body}[0][platform]
    Log    ${platform}

    # Extract subscription status from ${body} (it's a dictionary)
    ${serial_number}    Set Variable    ${body}[0][serial_number]
    Log    ${serial_number}

Test Teardown
    Close All Browsers