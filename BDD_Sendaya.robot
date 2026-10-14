*** Settings ***
Library           SeleniumLibrary

# Test Setup  Open TodoMVC Page Using Chrome Browser


*** Test Cases ***
Login With Admin
    [Documentation]    This test case is to test login with BDD syntax
    Given J ai recherché "sandaya" sur google
    And J ai recuperé le premier resultat contenant "sandaya"
    And Je suis sur la page d'accueil

    When Je fais une recherche de "location" pour "2" personnes pour le mois de "Septembre"
    And Je selectionne le premier resultat

    Then J ai acces au lien menant vers les prix de la reservation
    And J'ai acces aux infos pratiques du camping

*** Keywords ***
J ai recherché "${mot-cle}" sur google
    Open Browser	http://www.google.com	Chrome    options=add_argument("--incognito"); add_argument("--ignore-certificate-errors")
    Maximize Browser Window

    Click Button    id:W0wltc    #refuser les cookies

    Input Text      id:APjFqb    ${mot-cle}    clear=True
    Click Element   xpath: //input[@id='gbqfbb']/preceding-sibling::input[@class='gNO89b']

    Sleep  5s

J ai recuperé le premier resultat contenant "${mot-cle}"
    Wait Until Element Is Visible    id:res
    Click Element   xpath: (//div[@data-async-context='query:${mot-cle}']/descendant::a[contains(@href,'${mot-cle}.fr')])[1]

    Sleep  5s

Je suis sur la page d'accueil
    Wait Until Element Is Visible    id:didomi-popup
    Click Element   class:didomi-continue-without-agreeing
    
    Sleep  5s

Je fais une recherche de "${type}" pour "${nbPersonnes}" personnes pour le mois de "${mois}"
    Select From List By Value    id:availability_search_type            ${type}
    Select From List By Value    id:availability_search_nb_people       ${nbPersonnes}
    Run Keyword    Rechercher une reservation pour le mois de ${mois}

    Sleep  5s
  
Rechercher une reservation pour le mois de ${mois_a_reserver}
    Click Element   id:datepicker-start-field
    ${mois_actuel}=    Get Text     xpath: (//b[@class='caleran-month-switch'])[1]

    WHILE    '${mois_actuel}' != '${mois_a_reserver}'
        Click Element   xpath: (//i[@class='sandaya-pictos-arrow-right-solid'])[1]
        Wait Until Element Does Not Contain        xpath: (//b[@class='caleran-month-switch'])[1]    ${mois_actuel}
        ${mois_actuel}=    Get Text    xpath: (//b[@class='caleran-month-switch'])[1]
    END
    Click Element   xpath: (//div[@class='caleran-day'])[1]

    Click Element   xpath: //div[@class='caleran-day caleran-start caleran-hovered caleran-hovered-last']/following-sibling::div[7]

    Click Button    id:availability_search_submit

    Sleep  5s

Je selectionne le premier resultat
    Wait Until Element Is Visible    id:section_dispos
    Click Element   xpath: (//div[@id='section_dispos']/div)[1]

    Sleep  5s


J ai acces au lien menant vers les prix de la reservation
    Element Should Be Visible   id:availability_search_submit
    Scroll Element Into View    id:availability_search_submit

    Sleep  5s

J'ai acces aux infos pratiques du camping
    Element Should Be Visible   class:usefull-info-block
    Scroll Element Into View    class:usefull-info-block

    Sleep  5s