*** Settings ***
Library    DataDriver    .xlsx
Library    RPA.Browser
Resource    ../resources/challenge.resource
Resource    ../resources/environment.resource
Suite Setup    Start Challenge 'Input Forms'
Suite Teardown    Finish Challenge
Variables    ../variables/challenge_input_forms_pom.yaml
Test Template    Fill in input fields


*** Tasks ***
Fill in forms for ${First Name} ${Last Name}

*** Keywords ***
Fill in input fields
    [Arguments]    ${First Name}    ${Last Name}    ${Company Name}    ${Role in Company}    ${Address}    ${Phone Number}    ${Email}
    Make parameters global    ${First Name}    ${Last Name}    ${Company Name}    ${Role in Company}    ${Address}    ${Phone Number}    ${Email}
    FOR  ${key}  ${value}  IN  &{input_form}
      Fill in "${key}"
    END
    wait and click button    //*[@value='Submit']

Fill in "${field}"
    ${field_props}    Set Variable    ${input_form.${field}}
    ${value}    Get variable value    ${${field_props.value}}
    input text when element is visible    ${field_props.xpath}    ${value}

Finish Challenge
    Capture Page Screenshot    result.png
    [Teardown]    Close Browser