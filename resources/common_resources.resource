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
${DEVICE_DATA_API}    https://random-data-api.com/api/device/random_device?size=2

# Locators
${CUSTOMER_MENU}    //a[contains(.,'Partnerek')]
${CUSTOMER_GRID}    //h4[.='Ügyfelek']
${ADD_BUTTON}    //button[@aria-label='Add']
${CUSTOMER_NAME}    //input[@id='name']   # First name, Last name
${E-MAIL_TITLE}    //td[contains(.,'E-mail')]
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
${ADD_TOOL}    //span[.='Add']
${MANUFACTORERS_NAME}    //input[@id='name']
${CUSTOMER_FIELD}    //input[@aria-placeholder='Ügyfél']
${LOCATION_FIELD}    //input[@aria-placeholder='Telephely']    
${DESCRIPTION_PLATFORM}    //textarea[@id='Desc']
${COMMENT_AT_TOOL_SERIAL_NUMBER}    //textarea[@id='Comm']
${EXCEL_EXPORT}    //button[@aria-label='Excel Export']
${FILTER_FOR_LOCATION}    //input[@id='Grid_ToolbarSearchBox']
${SEARCH_ICON}    //span[@class='e-searchclear e-search-icon e-icons e-input-group-icon']
${EXCEL_DOWNLOAD_PATH}    C:\Users\Andi\Downloads    

*** Keywords ***

Test Setup
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    BWP Index

Open Customer Menu
    Click Element    ${CUSTOMER_MENU}
    # Sleep    5s    ${CUSTOMER_GRID}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}

Open Location Menu
    Click Element    ${LOCATIONS_MENU}
    # Sleep    5s    ${LOCATIONS_GRID}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}

Record User Data
    Open Customer Menu
    Click Button    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_NAME}    timeout=10s
    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${CUSTOMER_GRID}    timeout=10s

Record Location Data
    Open Location Menu
    Click Button    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${LOCATION_CUSTOMER}    timeout=10s
    Select From List By Label    ${LOCATION_CUSTOMER_DROPDOWN}    ${customer_name}
    Click Button    ${SAVE_BUTTON}
    Wait Until Element Is Visible    ${LOCATIONS_GRID}