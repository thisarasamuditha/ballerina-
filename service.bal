import ballerina/http;


service /expenses on new http:Listener(9090) {

    isolated resource function post addExpense(@http:Payload expenses exp) returns string|error? {
        return addExpense(exp);
    }
    
    isolated resource function get [int id]() returns expenses|error? {
        return getExpense(id);
    }
    
    isolated resource function get getAllExpenses() returns expenses[]|error? {
        return getAllExpenses();
    }
    
    isolated resource function put updateExpense(@http:Payload expenses exp) returns string|error? {
        return updateExpense(exp);
    }
    
    isolated resource function delete [int id]() returns string|error? {
        return removeExpense(id);       
    }

}