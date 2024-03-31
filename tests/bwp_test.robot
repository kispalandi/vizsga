*** Settings ***
Resource    ../resources/common_resources.resource

*** Variables ***
${URL}    https://bwpool.azurewebsites.net/   
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${USER_DATA_API}    https://random-data-api.com/api/users/random_user?size=1
${TOOL_DATA_API}    https://random-data-api.com/api/device/random_device?size=2

*** Keywords ***
Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

# Navigate To Customer Menu
    Go To    ${URL}/Customer
    Click Element    ${CUSTOMER_MENU}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}

*** Test Cases ***

Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

# Open Customer Menu
    Wait Until Element Is Enabled    ${CUSTOMER_MENU}    timeout=10s
    Sleep    2s
    Click Element    ${CUSTOMER_MENU}
    Sleep    2s    ${CUSTOMER_GRID}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}
    Capture Page Screenshot

# User Api Call Test
    # GET Json response from URL and save the Json body into the ${body} variable
    ${response}    GET    ${USER_DATA_API}
    # Should Be Equal As Strings    ${response.status_code}    200
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

# Add New Customer
    Wait Until Element Is Enabled    ${ADD_BUTTON}    timeout=10s
    Sleep    2s
    Click Button    ${ADD_BUTTON}

    Wait Until Element Is Visible    ${CUSTOMER_NAME}    timeout=10s

    Input Text    ${CUSTOMER_NAME}    ${first_name} ${last_name}
    Input Text    ${E-MAIL_FIELD}    ${email}
    Input Text    ${COMMENT}    ${id}

    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}    timeout=10s
    Capture Page Screenshot

# Fill Customer Location Form
    Open Location Menu
    Wait Until Element Is Enabled     ${ADD_BUTTON}
    Sleep    2s
    Click Button    ${ADD_BUTTON}
    Sleep    2s    
    Wait Until Page Contains Element    ${LOCATION_CUSTOMER}    timeout=10s
    Sleep    2s    
    Click Element    ${LOCATION_CUSTOMER_DROPDOWN}
    Input Text    ${LOCATION_CUSTOMER}    ${first_name} ${last_name}
    Input Text    ${CITY_LOCATOR}    ${city}    
    Input Text    ${ZIPCODE_LOCATOR}    ${zip_code}   
    Input Text    ${STREET_NAME_LOCATOR}    ${street_name}    
    Input Text    ${STREET_ADDRESS_LOCATOR}    ${street_address}    
    Click Button    ${SAVE_BUTTON}    
    Sleep    2s
    Wait Until Element Is Visible    ${LOCATIONS_GRID}    timeout=10s
    Capture Page Screenshot

# Tool Api Call Test
    ${response}    GET    ${TOOL_DATA_API}
    ${body}    Set Variable    ${response.json()}
    
    FOR    ${items}    IN RANGE    0    2
        ${id}    Set Variable    ${body}[${items}][id]
        ${manufacturer}    Set Variable    ${body}[${items}][manufacturer]
        ${model}    Set Variable    ${body}[${items}][model]
        ${platform}    Set Variable    ${body}[${items}][platform]
        ${serial_number}    Set Variable    ${body}[${items}][serial_number]
        # Navigate To Tool Menu
        Go To    ${URL}/Tool
        Click Element    ${TOOLS_MENU}
        Wait Until Page Contains Element    ${TOOLS_GRID}

        Wait Until Element Is Enabled    ${ADD_BUTTON}    timeout=10s
        Sleep    2s
        Click Button    ${ADD_BUTTON}
        Sleep    2s
        
        Wait Until Element Is Visible    ${MANUFACTORERS_NAME}    timeout=10s
        Input Text    ${MANUFACTORERS_NAME}    ${manufacturer} ${model}
        Input Text    ${CUSTOMER_FIELD}    ${first_name} ${last_name}
        Input Text    ${LOCATION_FIELD}    ${zip_code} ${city} ${street_name} ${street_address}
        Input Text    ${DESCRIPTION_PLATFORM}    ${platform}
        Input Text    ${COMMENT_AT_TOOL_SERIAL_NUMBER}    ${serial_number}
        Sleep    2s  
        Click Button    ${SAVE_BUTTON}    
        Wait Until Element Is Visible    ${TOOLS_GRID}    timeout=10s
        Capture Page Screenshot
    END
  
# Excel Export
    Click Button    ${EXCEL_EXPORT}
        ${download}    Run Keyword And Return Status    File Should Exist    ${EXCEL_DOWNLOAD_PATH}Export.*
        IF  "${download}" == "${False}"
           log    "check download path is correct"    WARN
        Capture Page Screenshot
        END
        
# Navigate To Locations Menu
    Go To    ${URL}/Location
    Click Element    ${LOCATIONS_MENU}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}
    Capture Page Screenshot

# Filter For Recorded Location
    Wait Until Page Contains    ${FILTER_FOR_LOCATION}    timeout=20s
    Sleep    2s
    Input Text    ${FILTER_FOR_LOCATION}    ${city}
    Click Element    ${SEARCH_ICON}
    Sleep    2s
    Wait Until Element Is Visible    ${LOCATION_CUSTOMER}    timeout=10s
    Capture Page Screenshot 
    
# Click On Street URL
    Click Link    //a[contains(.,"${street_name}")]
    Capture Page Screenshot
   
Test Teardown
    Close All Browsers