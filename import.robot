*** Settings ***
Library    String
Library    SeleniumLibrary
Library    Collections
Library    JSONLibrary
Library    json
Library    RequestsLibrary

Variables    Config/Config.yaml
Variables    Resources/TestData/User_Bank_Account.yaml
Variables    Resources/TestData/Response_Msg_Condition.yaml

Resource    Resources/Keywords/Global/DB_Common.robot
Resource    Resources/Keywords/Global/API_Common.robot
Resource    Resources/Keywords/Global/Common.robot
