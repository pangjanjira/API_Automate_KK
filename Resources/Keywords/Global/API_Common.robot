*** Settings ***
Library    RequestsLibrary
Library    SeleniumLibrary
Resource    ${CURDIR}/../../../import.robot

*** Keywords ***
Transfer Money To Another Bank Account For Success Case
    [Arguments]     ${amount}    ${sendingAccount}    ${receivingAccount}    ${typeReceivingAccount}    ${receivingBankCode}

    &{header}=    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json

    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/Format_Transfer.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..amount     ${amount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..sendingAccount    ${sendingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..receivingAccount    ${receivingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..typeReceivingAccount    ${typeReceivingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..receivingBankCode    ${receivingBankCode}
    ${body}     json.Dumps    ${json}
    log    ${\n}${\n}${body}
    log to console    ${\n}${\n}${body}

    ${end_point}=   Set Variable    ${environment.qa.api.transfer_api}
    ${response}=     POST    ${end_point}     headers=&{header}    data=${body}
    log    ${\n}${response.json()}

    ${response_status}=    Set Variable    ${response.json()}[status]
    ${response_code}=    Set Variable    ${response.json()}[code]
    ${response_amount}=    Set Variable    ${response.json()}[data][amount]
    ${response_sendingAccountNo}=    Set Variable    ${response.json()}[data][sendingAccountNo]
    ${response_receivingAccountNo}=    Set Variable    ${response.json()}[data][receivingAccountNo]
    ${response_receivingBankCode}=    Set Variable    ${response.json()}[data][receivingBankCode]
    ${response_transferReferenceID}=    Set Variable    ${response.json()}[data][transferReferenceID]

    RETURN    ${response_status}    ${response_code}    ${response_amount}
    ...    ${response_sendingAccountNo}    ${response_receivingAccountNo}    ${response_receivingBankCode}
    ...    ${response_transferReferenceID}

Transfer Money To Another Bank Account For Failed Case
    [Arguments]     ${amount}    ${sendingAccount}    ${receivingAccount}    ${typeReceivingAccount}    ${receivingBankCode}

    &{header}=    Create Dictionary
    ...    accept=application/json
    ...    Content-Type=application/json

    ${json}=    JSONLibrary.Load Json From File     ${CURDIR}/../../TestData/Format_Transfer.json
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..amount     ${amount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..sendingAccount    ${sendingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..receivingAccount    ${receivingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..typeReceivingAccount    ${typeReceivingAccount}
    ${json}=    JSONLibrary.Update Value To Json    ${json}    $..receivingBankCode    ${receivingBankCode}
    ${body}     json.Dumps    ${json}
    log    ${\n}${\n}${body}

    ${end_point}=   Set Variable    ${environment.qa.api.transfer_api}
    ${response}=     POST    ${end_point}     headers=&{header}    data=${body}
    log    ${\n}${response.json()}

    ${response_status}=    Set Variable    ${response.json()}[status]
    ${response_code}=    Set Variable    ${response.json()}[code]
    ${response_message}=    Set Variable    ${response.json()}[error][message]

    RETURN    ${response_status}    ${response_code}    ${response_message}