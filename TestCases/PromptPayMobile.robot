*** Settings ***
Test Setup    Clear Transaction In Transfer History
Library    JSONLibrary
Resource    ${CURDIR}/../import.robot

*** Variables ***
${receivingBankCode}=   KK
${increase_amount}=    1000000.00
${no_increase_amount}=    0.00

*** Test Cases ***
API_TC_0632 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0632     PROMPTPAY_MOBILE    ACTIVE    NEGATIVE    INSUFFICIENT_FUND

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.insufficient_fund.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.insufficient_fund.msg}
    Verify Response Code With API    ${response_code}    ${response.insufficient_fund.code}

API_TC_0648 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,999.991
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0648     PROMPTPAY_MOBILE    INACTIVE    NEGATIVE    INVALID_BANK_ACCOUNT

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999999.991
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${response_transferReferenceID}    ${response.invalid_bank_account.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.inactive.account_no}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.invalid_bank_account.msg}
    Verify Response Code With API    ${response_code}    ${response.invalid_bank_account.code}

API_TC_0656 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount > 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 20,000,000.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0656     PROMPTPAY_MOBILE    ACTIVE    NEGATIVE    TRANSACTION_LIMIT_DAILY

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    1000000.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.transaction_limit_daily.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transaction_limit_daily.msg}
    Verify Response Code With API    ${response_code}    ${response.transaction_limit_daily.code}

API_TC_0668 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount < 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0668     PROMPTPAY_MOBILE    ACTIVE    NEGATIVE    TRANSFER_UNSUCCESSFUL_WITH_LEGAL

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.009

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.inactive.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.inactive.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.inactive.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.transfer_unsuccessful_with_legal.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.inactive.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transfer_unsuccessful_with_legal.msg}
    Verify Response Code With API    ${response_code}    ${response.transfer_unsuccessful_with_legal.code}

API_TC_0739 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount = 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0739     PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    0.01

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_0767 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount = 0.01 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,999,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0767   PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    999999.00
    ${transfer_amount}    Set Variable    0.01

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_0878 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount between 0.01 to 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,899,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0878   PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    899999.00
    ${transfer_amount}    Set Variable    100000.00

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_0906 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount between 0.01 to 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,900,000.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_0906   PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${increase_amount}
    ${amount_boundary_2}    Set Variable    900000.00
    ${transfer_amount}    Set Variable    100000.00

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1017 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount = 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 18,999,999.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1017   PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    999999.00
    ${transfer_amount}    Set Variable    1000000.00

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1045 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount = 20 million per day and transaction time out < 30 second and transfer amount = 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 19,000,000.00
#    [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1045   PROMPTPAY_MOBILE    ACTIVE    POSITIVE    SUCCESS

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    1000000.00
    ${transfer_amount}    Set Variable    1000000.00

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_amount}    ${response_sendingAccountNo}
    ...    ${response_receivingAccountNo}    ${response_receivingBankCode}    ${response_transferReferenceID}
    ...    Transfer Money To Another Bank Account For Success Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.success.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_status}
    Verify Transfer Amount By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_amount}
    Verify Sender Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_sendingAccountNo}
    Verify Receiver Account By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response_receivingAccountNo}
    Verify Response Message With API    ${response_status}    ${response.success.msg}
    Verify Response Code With API    ${response_code}    ${response.success.code}

API_TC_1148 Verify transfer money from customer’s saving account to another bank account with PromptPay mobile using the check API when transfer amount < 20 million per day and transaction time out < 30 second and transfer amount > 1,000,000.00 and make a transaction before 01:00 AM
    [Documentation]    Prepare Transaction amount per day = 18,999,998.00
#   [Tags]    Test Case ID    |    Bank Account Type    |    Sender Bank Account Status    |   Case Type    |    Response Message Case
    [Tags]    API_TC_1148     PROMPTPAY_MOBILE    ACTIVE    NEGATIVE    TRANSACTION_LIMIT

    ${amount_boundary_1}    Set Variable    ${no_increase_amount}
    ${amount_boundary_2}    Set Variable    999998.00
    ${transfer_amount}    Set Variable    1000001.00

    Insert Transaction For Prepare Precondition Test Data    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}    ${amount_boundary_1}    ${amount_boundary_2}
    ${response_status}    ${response_code}    ${response_message}
    ...    Transfer Money To Another Bank Account For Failed Case    ${transfer_amount}    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    ...    ${user.receiver.bank_type.promptPay_mobile.status.active.type}    ${receivingBankCode}

    Verify Response Message With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${response.transaction_limit.msg}
    Verify Transfer Amount With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${transfer_amount}
    Verify Sender Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.sender.bank_type.bank_account_no.status.active.account_no}
    Verify Receiver Account With Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_transferReferenceID}    ${user.receiver.bank_type.promptPay_mobile.status.active.account_no}
    Verify Response Message By Compare API And Database    ${user.sender.bank_type.bank_account_no.status.active.account_no}    ${response_receivingAccountNo}    ${response_message}
    Verify Response Message With API    ${response_message}    ${response.transaction_limit.msg}
    Verify Response Code With API    ${response_code}    ${response.transaction_limit.code}
