*** Settings ***
Test Setup    Clear Transaction In Transfer History
Library    JSONLibrary
Resource    ${CURDIR}/../import.robot

*** Variables ***
${receivingBankCode}=   KK
${increase_amount}=    1000000.00
${no_increase_amount}=    0.00

${SENDER_BANK_ACCOUNT_NO_ACTIVE}=    ${user.sender.bank_type.bank_account_no.status.active.account_no}
${SENDER_BANK_ACCOUNT_NO_INACTIVE}=    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}

${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}=    ${user.receiver.bank_type.promptPay_national_id.status.active.account_no}
${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE}=    ${user.receiver.bank_type.promptPay_national_id.status.inactive.account_no}

${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}=    ${user.receiver.bank_type.promptPay_national_id.status.active.type}
${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE_TYPE}=    ${user.receiver.bank_type.promptPay_national_id.status.inactive.type}

*** Test Cases ***
#TestJA
#    log to console    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}

API_TC_1263 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1263     PROMPTPAY_NATIONAL_ID    ACTIVE    NEGATIVE    INSUFFICIENT_FUND

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.insufficient_fund.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.insufficient_fund.msg}
    Verify Response Code With API    ${response_code}    ${response.insufficient_fund.code}

API_TC_1279 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,999.991
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1279     PROMPTPAY_NATIONAL_ID    INACTIVE    NEGATIVE    INVALID_BANK_ACCOUNT

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999999.991
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${response_transferReferenceID}    ${response.invalid_bank_account.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_INACTIVE}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.invalid_bank_account.msg}
    Verify Response Code With API    ${response_code}    ${response.invalid_bank_account.code}

API_TC_1287 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount > 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 20,000,000.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1287     PROMPTPAY_NATIONAL_ID    ACTIVE    NEGATIVE    TRANSACTION_LIMIT_DAILY

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    1000000.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.transaction_limit_daily.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transaction_limit_daily.msg}
    Verify Response Code With API    ${response_code}    ${response.transaction_limit_daily.code}

API_TC_1299 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1299     PROMPTPAY_NATIONAL_ID    ACTIVE    NEGATIVE    TRANSFER_UNSUCCESSFUL_WITH_LEGAL

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.transfer_unsuccessful_with_legal.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_INACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transfer_unsuccessful_with_legal.msg}
    Verify Response Code With API    ${response_code}    ${response.transfer_unsuccessful_with_legal.code}

API_TC_1370 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount = 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1370     PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.01

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1398 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount = 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1398   PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999999.00
    ${transfer_amount}    Set Variable    0.01

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1509 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount between 0.01 to 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,899,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1509   PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    899999.00
    ${transfer_amount}    Set Variable    100000.00

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1537 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount between 0.01 to 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,900,000.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1537   PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    900000.00
    ${transfer_amount}    Set Variable    100000.00

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1648 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount = 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 18,999,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1648   PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    999999.00
    ${transfer_amount}    Set Variable    1000000.00

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1676 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount = 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,000,000.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1676   PROMPTPAY_NATIONAL_ID    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    1000000.00
    ${transfer_amount}    Set Variable    1000000.00

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1779 Verify transfer money from customer’s saving account to another bank account with PromptPay national ID using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount > 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 18,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1779     PROMPTPAY_NATIONAL_ID    ACTIVE    NEGATIVE    TRANSACTION_LIMIT

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    1000001.00

    Insert Transaction For Prepare Precondition Test Data    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    ...    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE_TYPE}    ${receivingBankCode}

    Verify Response Message With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${response.transaction_limit.msg}
    Verify Transfer Amount With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}
    Verify Receiver Account With Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_transferReferenceID}    ${RECEIVER_PROMPYPAY_NATIONAL_ID_ACTIVE}
    Verify Response Message By Compare API And Database    ${SENDER_BANK_ACCOUNT_NO_ACTIVE}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transaction_limit.msg}
    Verify Response Code With API    ${response_code}    ${response.transaction_limit.code}
