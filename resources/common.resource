# Settings e Keywords
*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary

*** Keywords ***
Create Token
    [Arguments]    ${url}

    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=${url}/auth    json=${body}

    Status Should Be    200
    ${token}    Set Variable    ${response.json()}[token]
    Set Suite Variable    ${token}        # fica visivel para todos os testes durante a execução da suite
    Log To Console    ${token}

Get Booking Id
    [Arguments]    ${url}    ${firstname}    ${lastname}

    ${response}    GET    url=${url}/booking?firstname=${firstname}&lastname=${lastname}
    ${response_body}    Set Variable    ${response.json()}    
    Log To Console    ${response_body}

    Status Should Be    200

    ${booking_id}    Set Variable    ${response_body}[0][bookingid]    # faz a extração do id
    Set Suite Variable    ${booking_id}    # (visivel para todos os testes durante a execução (variavel publica)

Gerar um Nome aleatório
    [Documentation]    Gerador de Nome válido
    ${gerar_nome}    FakerLibrary.name
    Set Global Variable    ${nome}    ${gerar_nome}
    RETURN                 ${nome}

