*** Settings ***
Library    DatabaseLibrary
Library    DateTime
Library    SeleniumLibrary
Resource    ${CURDIR}/../../../import.robot

*** Keywords ***
DB Connect To SQL Database
    [Arguments]    ${db_name}    ${db_username}    ${db_password}    ${db_host}    ${db_port}
    Connect To Database    dbapiModuleName=pymysql    dbName=${db_name}    dbUsername=${db_username}    dbPassword=${db_password}    dbHost=${db_host}    dbPort=${db_port}

DB Connect To Database Transfer
    DB Connect To SQL Database    ${environment.qa.database.pymysql.db_name}    ${environment.qa.database.pymysql.user}    
    ...    ${environment.qa.database.pymysql.password}    ${environment.qa.database.pymysql.host}    ${environment.qa.database.pymysql.port}

Insert Transaction For Prepare Precondition Test Data
    [Arguments]    ${sending_account}    ${receiving_account}    ${amount_boundary_1}    ${amount_boundary_2}

    DB Connect To Database Transfer
    FOR    ${id}    IN RANGE    1   19
        ${current_time}    Get DateTime
        ${transfer_ref_id}    Generate random string    6     0123456789
	    Execute Sql String   INSERT INTO transfer VALUES ('${id}', '${sending_account}', '${receiving_account}', '1000000', 'SUCCESS', '${transfer_ref_id}', '${current_time}', '${current_time}');
	END
    
	IF    "${amount_boundary_1}" != "0.00"
	    Execute Sql String   INSERT INTO transfer_history VALUES ('19', '${sending_account}', '${receiving_account}', '${amount_boundary_1}', 'SUCCESS', '${transfer_ref_id}', '${current_time}', '${current_time}');
	    Execute Sql String   INSERT INTO transfer_history VALUES ('20', '${sending_account}', '${receiving_account}', '${amount_boundary_2}', 'SUCCESS', '${transfer_ref_id}', '${current_time}', '${current_time}');
	ELSE
        Execute Sql String   INSERT INTO transfer_history VALUES ('20', '${sending_account}', '${receiving_account}', '${amount_boundary_2}', 'SUCCESS', '${transfer_ref_id}', '${current_time}', '${current_time}');
	END

Query Transaction Into Database
    [Arguments]    ${sending_account}    ${transfer_ref_id}
    DB Connect To Database Transfer
    ${result}     Query     SELECT * FROM transfer_history WHERE sending_account = '${sending_account}' AND transfer_ref_id = '${transfer_ref_id}'
    RETURN    ${result}

Clear Transaction In Transfer History
    DB Connect To Database Transfer
    ${result}     Execute Sql String     TRUNCATE TABLE  transfer_history