*** Settings ***
Library    DataDriver    file=challenge_input_forms.xlsx
Library    RPA.Browser
Resource    ../resources/challenge.resource
Resource    ../resources/environment.resource
Suite Setup    Run Setup Only Once    Start Challenge 'Input Forms'
Suite Teardown    Run Teardown Only Once    Finish Challenge
Variables    ../variables/challenge_input_forms_pom.yaml
Test Template    Fill in input fields


*** Tasks ***
Fill in forms ${First Name} ${Last Name}

*** Keywords ***
Fill in input fields
    [Arguments]    ${First Name}    ${Last Name}    ${Company Name}    ${Role in Company}    ${Address}    ${Phone Number}    ${Email}
    Make parameters global    ${First Name}    ${Last Name}    ${Company Name}    ${Role in Company}    ${Address}    ${Phone Number}    ${Email}
    FOR  ${key}  ${value}  IN  &{input_form}
      Fill in "${key}"
    END
    wait and click button    xpath://input[@value='Submit']

Fill in "${field}"
    ${field_props}    Set Variable    ${input_form.${field}}
    ${value}    Get variable value    ${${field_props.value}}
    Fill in field really fast   ${field_props.xpath}    ${value}

Fill in field really fast
    [Arguments]    ${xpath}    ${value}
    ${result}=    Execute Javascript    document.evaluate("${xpath}",document.body,null,9,null).singleNodeValue.value="${value}";
    [Return]    ${result}