*** Settings ***
Library    RPA.Browser
Library    pabot.PabotLib

*** Keywords ***
Start challenge '${challenge}'
    Open and wait for RPA challenge website
    wait until element is visible    xpath://a[.="${challenge}"]
    click link    xpath://a[.="${challenge}"]
    wait and click button    xpath://button[.="Start"]

Open and wait for RPA challenge website
    Open RPA challenge website
    Set proper browser size

Open RPA challenge website
    ${active_browser}    open available browser    http://www.rpachallenge.com/
    set parallel value for key    active_browser    ${active_browser}

Finish Challenge
    Capture Page Screenshot    result-{index}.png
    [Teardown]    Close Browser

Set proper browser size
    set window size    1900    1200

Switch to active browser
    ${active_browser}    get parallel value for key    active_browser
    Switch Browser    ${active_browser}