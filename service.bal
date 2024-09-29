import ballerina/http;


service /employees on new http:Listener(9090) {

    isolated resource function post addEmployee(@http:Payload Employee emp) returns string|error? {
        return addEmployee(emp);
    }
    
    isolated resource function get [int id]() returns Employee|error? {
        return getEmployee(id);
    }
    
    isolated resource function get .() returns Employee[]|error? {
        return getAllEmployees();
    }
    
    isolated resource function put updateEmployee(@http:Payload Employee emp) returns string|error? {
        return updateEmployee(emp);
    }
    
    isolated resource function delete [int id]() returns string|error? {
        return removeEmployee(id);       
    }

}