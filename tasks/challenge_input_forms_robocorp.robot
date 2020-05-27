*** Settings ***
Documentation     Robot to solve the first challenge at rpachallenge.com, which consists of
...               filling a form that randomly rearranges itself for ten times, with data
...               taken from a provided Microsoft Excel file.
Library           RPA.Browser
Library           RPA.HTTP
Library           RPA.Excel.Files

*** Variables ***
${people}    @{EMPTY}

*** Keywords ***
Get The List Of People From The Excel File
    Open Workbook    challenge.xlsx
    ${table}=    Read Worksheet As Table    header=${TRUE}
    Close Workbook
    [Return]    ${table}


*** Keywords ***
Set Value By Xpath
    [Arguments]    ${xpath}    ${value}
    ${result}=    Execute Javascript    document.evaluate('${xpath}',document.body,null,9,null).singleNodeValue.value='${value}';
    [Return]    ${result}


*** Keywords ***
Fill And Submit The Form
    [Arguments]    ${person}
    Set Value By Xpath    //input[@ng-reflect-name="labelFirstName"]  ${person}[First Name]
    Set Value By Xpath    //input[@ng-reflect-name="labelLastName"]  ${person}[Last Name]
    Set Value By Xpath    //input[@ng-reflect-name="labelCompanyName"]  ${person}[Company Name]
    Set Value By Xpath    //input[@ng-reflect-name="labelRole"]  ${person}[Role in Company]
    Set Value By Xpath    //input[@ng-reflect-name="labelAddress"]  ${person}[Address]
    Set Value By Xpath    //input[@ng-reflect-name="labelEmail"]  ${person}[Email]
    Set Value By Xpath    //input[@ng-reflect-name="labelPhone"]  ${person}[Phone Number]
    Click Button    Submit


*** Tasks ***
Start The Challenge
    Open Available Browser    http://rpachallenge.com/
    Download  http://rpachallenge.com/assets/downloadFiles/challenge.xlsx    overwrite=${TRUE}
    ${list_of_people}=    Get The List Of People From The Excel File
    Set Global Variable    ${people}    ${list_of_people}


*** Tasks ***
Fill The Forms
    Click Button    Start
    FOR  ${person}  IN  @{people}
      Fill And Submit The Form  ${person}
    END


*** Tasks ***
Collect The Results
    Capture Element Screenshot    css:div.congratulations
    Close All Browsers