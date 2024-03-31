*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    OperatingSystem

*** Variables ***
${URL}    https://bwpool.azurewebsites.net/   
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index

# API Locators
${USER_DATA_API}    https://random-data-api.com/api/users/random_user?size=1
${TOOL_DATA_API}    https://random-data-api.com/api/device/random_device?size=2

# Locators
${CUSTOMER_MENU}    //a[contains(.,'Partnerek')]
${CUSTOMER_GRID}    //h4[.='Ügyfelek']
${ADD_BUTTON}    //button[@aria-label='Add']
${CUSTOMER_NAME}    //input[@id='name']   # First name, Last name
${E-MAIL_FIELD}    //input[@id='email']
${PHONE_NUMBER}    //input[@class='e-control e-numerictextbox e-lib e-input']    # Remain empty
${COMMENT}    //input[@id='comment']
${SAVE_BUTTON}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']
${LOCATIONS_MENU}    //a[contains(.,'Telephelyek')]
${LOCATIONS_GRID}    //h4[.='Telephelyek']
${LOCATION_CUSTOMER}    //input[@class='e-control e-combobox e-lib e-input']
${LOCATION_CUSTOMER_DROPDOWN}    //span[@class='e-input-group-icon e-ddl-icon e-icons e-ddl-disable-icon']   
${CITY_LOCATOR}    //input[@id='varos']
${ZIPCODE_LOCATOR}    //input[@id='zip']
${STREET_NAME_LOCATOR}    //input[@id='utca']
${STREET_ADDRESS_LOCATOR}    //input[@id='szam']
${TOOLS_MENU}    //a[contains(.,'Eszközök')]
${TOOLS_GRID}    //h4[.='Eszközök']
${MANUFACTORERS_NAME}    //input[@id='name']
${CUSTOMER_FIELD}    //input[@aria-placeholder='Ügyfél']
${LOCATION_FIELD}    //input[@aria-placeholder='Telephely']    
${DESCRIPTION_PLATFORM}    //textarea[@id='Desc']
${COMMENT_AT_TOOL_SERIAL_NUMBER}    //textarea[@id='Comm']
${EXCEL_EXPORT}    //button[@aria-label='Excel Export']
${FILTER_FOR_LOCATION}    //input[@id='Grid_ToolbarSearchBox']
${SEARCH_ICON}    //span[@class='e-searchclear e-search-icon e-icons e-input-group-icon']

*** Keywords ***

Test Setup
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    BWP Index

Test Teardown
    Test Teardown
    [Teardown]  Close All Browsers
       
Navigate To Customer Menu
    Go To    ${URL}/Customer
    Wait Until Element Is Enabled    ${CUSTOMER_MENU}    timeout=10s
   
Navigate To Location Menu
    Go To    ${URL}/Location
    Click Element    ${LOCATIONS_MENU}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}

Navigate To Tool Menu
    Go To    ${URL}/Tool
    Click Element    ${TOOLS_MENU}
    Wait Until Page Contains Element    ${TOOLS_GRID}

Open Customer Menu
    Click Element    ${CUSTOMER_MENU}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}
    Capture Page Screenshot

Open Location Menu
    Click Element    ${LOCATIONS_MENU}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}

Adding Data
    Wait Until Element Is Enabled    ${ADD_BUTTON}    timeout=10s
    Sleep    2s
    Click Button    ${ADD_BUTTON}   