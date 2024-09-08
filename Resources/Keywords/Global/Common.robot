*** Settings ***
Library    DateTime
Library    SeleniumLibrary
Resource    ${CURDIR}/../../../import.robot

*** Keywords ***
Get DateTime
    [Arguments]    ${plus_hour}=+7    ${unit}=hours
    ${cur_time}    Get Current Date    UTC    ${plus_hour} ${unit}
    RETURN    ${cur_time}
    
Verify Sender Account With Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${expected_sending_account}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${sending_account_DB}    Set Variable    ${output_list}[0][1]
    Should Be Equal As Strings    ${sending_account_DB}    ${expected_sending_account}
    
Verify Receiver Account With Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${expected_receiving_account}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${receiving_account_DB}    Set Variable    ${output_list}[0][2]
    Should Be Equal As Strings    ${receiving_account_DB}    ${expected_receiving_account}

Verify Transfer Amount With Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${expected_amount}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${amount_DB}    Set Variable    ${output_list}[0][3]
    ${amount_DB_srt}    Convert To String    ${amount_DB}
    ${expected_amount_srt}    Convert To String    ${expected_amount}
    Should Be Equal As Strings    ${amount_DB_srt}    ${expected_amount_srt}

Verify Response Message With Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${expected_response_msg}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${resp_message_DB}    Set Variable    ${output_list}[0][4]
    Should Be Equal As Strings    ${resp_message_DB}    ${expected_response_msg}

Verify Sender Account By Compare API And Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${sending_account_API}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${sending_account_DB}    Set Variable    ${output_list}[0][1]
    Should Be Equal As Strings    ${sending_account_DB}    ${sending_account_API}

Verify Receiver Account By Compare API And Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${receiving_account_API}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${receiving_account_DB}    Set Variable    ${output_list}[0][2]
    Should Be Equal As Strings    ${receiving_account_DB}    ${receiving_account_API}

Verify Transfer Amount By Compare API And Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${amount_API}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${amount_DB}    Set Variable    ${output_list}[0][3]
    ${amount_DB_srt}    Convert To String    ${amount_DB}
    ${amount_API_srt}    Convert To String    ${amount_API}
    Should Be Equal As Strings    ${amount_DB_srt}    ${amount_API_srt}

Verify Response Message By Compare API And Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}    ${response_msg_API}
    @{output_list}    Query Transaction Into Database    ${sending_account}    ${transfer_ref_id}
    ${resp_message_DB}    Set Variable    ${output_list}[0][4]
    Should Be Equal As Strings    ${resp_message_DB}    ${response_msg_API}

Verify Response Message With API
    [Arguments]    ${response_msg_API}    ${expected_response_msg}
    Should Be Equal As Strings    ${response_msg_API}    ${expected_response_msg}

Verify Response Code With API
    [Arguments]    ${response_code_API}    ${expected_response_code}
    Should Be Equal As Strings    ${response_code_API}    ${expected_response_code}
