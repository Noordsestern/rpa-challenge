*** Variables ***
${First Name}    ${EMPTY}
${Last Name}    ${EMPTY}
${Company Name}    ${EMPTY}
${Phone Number}    ${EMPTY}
${Address}    ${EMPTY}
${Role in Company}    ${EMPTY}
${Email}    ${EMPTY}


*** Keywords ***
Make parameters global
    [Arguments]    ${First Name}    ${Last Name}    ${Company Name}    ${Role in Company}    ${Address}    ${Phone Number}    ${Email}
    Set Global Variable    ${First Name}    ${First Name}
    Set Global Variable    ${Last Name}    ${Last Name}
    Set Global Variable    ${Company Name}    ${Company Name}
    Set Global Variable    ${Role in Company}    ${Role in Company}
    Set Global Variable    ${Address}    ${Address}
    Set Global Variable    ${Phone Number}    ${Phone Number}
    Set Global Variable    ${Email}    ${Email}
