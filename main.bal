import ballerina/time; 
import ballerina/sql;
import ballerinax/mysql;

public type expenses record {|
    int id;
    string description;
    decimal amount;
    string category;
    time:Date date;
    
|};

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;

final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database="expense_tracker"
);

isolated function addExpense(expenses exp) returns string|error {
    sql:ExecutionResult result = check dbClient->execute(`
        INSERT INTO expenses (id, description, amount, category, date)
        VALUES (${exp.id}, ${exp.description}, ${exp.amount},  
                ${exp.category}, ${exp.date}) 
                
    `);
    int|string? lastInsertId = result.affectedRowCount;
    if lastInsertId is int {
        return "Added Successfully.";
    } else {
        return error("Unable to obtain last insert ID");
    }
}

isolated function getExpense(int id) returns expenses|error {
    expenses exp = check dbClient->queryRow(
        `SELECT * FROM expenses WHERE id = ${id}`
    );
    return exp;
}

isolated function getAllExpenses() returns expenses[]|error {
    expenses[] exp = [];
    stream<expenses, error?> resultStream = dbClient->query(
        `SELECT * FROM expenses`
    );
    check from expenses expense in resultStream
        do {
            exp.push(expense);
        };
    check resultStream.close();
    return exp;
}

isolated function updateExpense(expenses exp) returns string|error {
    sql:ExecutionResult result = check dbClient->execute(`
        UPDATE expenses SET
            description = ${exp.description}, 
            amount = ${exp.amount},
            category = ${exp.category},
            date = ${exp.date}
        WHERE id = ${exp.id}  
    `);
    int|string? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return "Updated Successfully.";
    } else {
        return error("Unable to obtain last insert ID");
    }
}

isolated function removeExpense(int id) returns string|error {
    sql:ExecutionResult result = check dbClient->execute(`
        DELETE FROM expenses WHERE id = ${id}
    `);
    int? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return "Deleted Successfully.";
    } else {
        return error("Unable to obtain the affected row count");
    }
}
