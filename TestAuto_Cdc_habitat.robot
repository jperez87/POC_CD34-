*** Settings ***
Library     SeleniumLibrary
Variables   variablesMda.py

*** Test Cases ***
Login With Admin
    [Documentation]    This test case is to test Research
    Rechercher "cdc-habitat" sur google

    Recuperer le premier resultat contenant "cdc-habitat"

    Gerer les coockies

    Rechercher un 3 pieces a Montpellier

    Retourner le nombre de resultats


*** Keywords ***
Rechercher "${mot-cle}" sur google
    Open Browser	http://www.google.com	Chrome    options=add_argument("--incognito")
    Maximize Browser Window

    Click Button    id:W0wltc    #refuser les cookies
    Input Text      id:APjFqb    ${mot-cle}    clear=True
        Click Element   xpath: //input[@id='gbqfbb']/preceding-sibling::input[@class='gNO89b']

    Sleep  5s

Recuperer le premier resultat contenant "${mot-cle}"
    Wait Until Element Is Visible    id:res
    Click Element   xpath: (//div[@data-async-context='query:${mot-cle}']/descendant::a[contains(@href,'${mot-cle}.fr')])[1]

    Sleep  5s

Gerer les coockies
    Wait Until Element Is Visible   id:CybotCookiebotDialog
    Wait Until Element Is Visible   id:CybotCookiebotDialogBodyLevelButtonLevelOptinDeclineAll
    Click Element                   id:CybotCookiebotDialogBodyLevelButtonLevelOptinDeclineAll
    
    Sleep  5s

Rechercher un ${nBpieces} pieces a ${ville}
    Sleep  5s

    Click Element   xpath: //*[@id='formRecherche']/descendant::div[@tabindex='0']
    Sleep  5s

    Click Element   xpath: //label[@for='${nBpieces}pcs']
    Sleep  1s

    Click Element   xpath: //li[text()='Ok']
    Sleep  1s

    Input Text    class:select2-search__field    ${ville}    clear=True
    Sleep  1s

    Wait Until Element Is Visible    id:select2-lbLieu-results
    Click Element                   xpath: //ul[@id='select2-lbLieu-results']/li[1]
    Sleep  1s

    Click Element   id:submitButtonRecherche
    
    Sleep  5s

Retourner le nombre de resultats
    Wait Until Element Is Visible   xpath: //div[@class='headerResults']    timeout=20s

    ${count} =	Get Element Count	xpath: //div[@class='cards ']/article
    Should Be True	${count} != 0	
    
    Sleep  5s
