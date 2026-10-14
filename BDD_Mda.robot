*** Settings ***
Library     SeleniumLibrary
Variables   variablesMda.py

*** Test Cases ***
Login With Admin
    [Documentation]    This test case is to test login with BDD syntax
    Given J accede au site mda

    And Je suis sur la page d'accueil

    When J accede a la page Faire une demande Handicap Adulte
    And Je veux deposer un dossier
    
    Then L ecran scrolle jusqu au paragraphe Depot de Dossier
    
    [Teardown]    TearDown

*** Keywords ***
TearDown
    Close Browser
    
J ai recherché "${mot-cle}" sur google
    Open Browser	https://www.google.com	Chrome    options=add_argument("--incognito")
    Maximize Browser Window
    
    Click Button    id:W0wltc    #refuser les cookies
    Input Text      id:ti6dpd    ${mot-cle}    clear=True

    Sleep  5s

    Click Element   xpath: //input[@name='btnK']

    Sleep  5s

J ai recuperé le premier resultat contenant "${mot-cle}"
    Wait Until Element Is Visible    id:res
    Click Element   xpath: (//div[@data-async-context='query:${mot-cle}']/descendant::a[contains(@href,'${mot-cle}.fr')])[1]

    Sleep  5s

J accede au site mda
    Open Browser    https://mda.herault.fr/    Chrome    options=add_argument("--incognito")
    Maximize Browser Window

Je suis sur la page d'accueil
    #Wait Until Element Is Visible    id:par10410

    Wait Until Element Is Visible    id:tarteaucitronAlertBig
    
    Sleep  1s

    Click Button   id:tarteaucitronAllDenied2    #refuser les cookies

    Sleep  5s

J accede a la page Faire une demande Handicap Adulte
    # Clic sur Handicap Adulte
    Click Element   id:nav1_1332
    Wait Until Element Is Visible    xpath: //*[@id='sousMenu_1332']/descendant::*[contains(text(),'Faire une demande')]
    
    #Clic sur Faire une Demande
    Click Element   xpath: //a[@href='https://mda.herault.fr/1339-faire-une-demande-handicap-adulte.htm']

    Sleep  5s

Je veux deposer un dossier
    Click Element   xpath: //a[@href='${depotDossierXpath}']
    
    Sleep  5s

L ecran scrolle jusqu au paragraphe Depot de Dossier
    Element Should Be Visible    ${idParagraphe}[DepotDossier]

    Sleep  5s