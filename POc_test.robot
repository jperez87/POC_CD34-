*** Settings ***
Documentation       log URL
Library             BuiltIn 

*** Variables ***
${URL}=     https://robotsparebinindustries.com/ 


*** Test Cases *** 
Open the intranet site and log in
    Display the intranet website

     
*** Keywords ***
Display the intranet website
    Log    Num value is ${URL}
