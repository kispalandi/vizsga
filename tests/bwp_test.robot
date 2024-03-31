*** Settings ***
Resource    ../resources/common_resources.resource

Test Setup    Test Setup
Test Teardown    Test Teardown

*** Variables ***

${full_name}    value
${street_name}    value
${email}    value
${id}    value
${city}    value
${zip_code}    value
${street_name}    value
${street_address}    value  

*** Keywords ***

Open Subject Website And Check the Title
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    ${EXPECTED_TITLE}

User Api Call Test
    ${response}    GET    ${USER_DATA_API}   
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
    ${full_name}    Set Variable    ${first_name} ${last_name}
        
    Set Global Variable    ${full_name}    
    Set Global Variable    ${street_name}
    Set Global Variable    ${email}   
    Set Global Variable    ${id}
    Set Global Variable    ${city}   
    Set Global Variable    ${zip_code}
    Set Global Variable    ${street_name}
    Set Global Variable    ${street_address}     

Add New Customer
    Adding Data
    Wait Until Element Is Visible    ${CUSTOMER_NAME}    timeout=10s

    Input Text    ${CUSTOMER_NAME}    ${full_name}
    Input Text    ${E-MAIL_FIELD}    ${email}
    Input Text    ${COMMENT}    ${id}

    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}    timeout=10s
    Capture Page Screenshot

Fill Customer Location Form
    Open Location Menu
    Adding Data
    Wait Until Element Is Enabled    ${LOCATION_CUSTOMER}    timeout=10s
    Sleep    2s    
    Click Element    ${LOCATION_CUSTOMER_DROPDOWN}
    Input Text    ${LOCATION_CUSTOMER}    ${full_name}
    Input Text    ${CITY_LOCATOR}    ${city}    
    Input Text    ${ZIPCODE_LOCATOR}    ${zip_code}   
    Input Text    ${STREET_NAME_LOCATOR}    ${street_name}    
    Input Text    ${STREET_ADDRESS_LOCATOR}    ${street_address}
    
    Click Button    ${SAVE_BUTTON}    
    Sleep    2s
    Wait Until Element Is Visible    ${LOCATIONS_GRID}    timeout=10s
    Capture Page Screenshot

Tool Api Call Test 
    ${response}    GET    ${TOOL_DATA_API}
    ${body}    Set Variable    ${response.json()}
    
    FOR    ${items}    IN RANGE    0    2
        ${id}    Set Variable    ${body}[${items}][id]
        ${manufacturer}    Set Variable    ${body}[${items}][manufacturer]
        ${model}    Set Variable    ${body}[${items}][model]
        ${platform}    Set Variable    ${body}[${items}][platform]
        ${serial_number}    Set Variable    ${body}[${items}][serial_number]

        Navigate To Tool Menu
        Adding Data
        
        Wait Until Element Is Visible    ${MANUFACTORERS_NAME}    timeout=10s
        Input Text    ${MANUFACTORERS_NAME}    ${manufacturer} ${model}
        Input Text    ${CUSTOMER_FIELD}    ${full_name}
        Input Text    ${LOCATION_FIELD}    ${zip_code} ${city} ${street_name} ${street_address}
        Input Text    ${DESCRIPTION_PLATFORM}    ${platform}
        Input Text    ${COMMENT_AT_TOOL_SERIAL_NUMBER}    ${serial_number}
        Click Button    ${SAVE_BUTTON}    
        Wait Until Element Is Visible    ${TOOLS_GRID}    timeout=10s
        Capture Page Screenshot
    END

Excel Export
    Wait Until Element Is Enabled    ${EXCEL_EXPORT}
    Sleep    2s
    Click Button    ${EXCEL_EXPORT}

Filter For Recorded Location
    Wait Until Element Is Enabled    ${FILTER_FOR_LOCATION}    timeout=10s
    Sleep    2s
    Input Text    ${FILTER_FOR_LOCATION}    ${full_name}
    Click Element    ${SEARCH_ICON}
    Sleep    2s
    Capture Page Screenshot

Click On Street URL
    Click Link    //a[contains(.,"${street_name}")]
    Capture Page Screenshot

*** Test Cases ***

Open Subject Website And Check the Title

    Open Browser To Login Page
    Navigate To Customer Menu
    Open Customer Menu
    User Api Call Test
    Add New Customer
    Fill Customer Location Form
    Tool Api Call Test
    Excel Export
    Navigate To Location Menu
    Open Location Menu
    Filter For Recorded Location
    Click On Street URL
  
    [Teardown]  Close All Browsers
