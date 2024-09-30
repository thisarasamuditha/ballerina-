CREATE DATABASE IF NOT EXISTS Company;

CREATE TABLE IF NOT exists Company.Employees (
	employee_id INTEGER AUTO_INCREMENT PRIMARY KEY,
	first_name  VARCHAR(255) NOT NULL,
	last_name   VARCHAR(255) NOT NULL,
	email       VARCHAR(255) NOT NULL,
	phone       VARCHAR(50) NOT NULL ,
	hire_date   DATE NOT NULL,
	manager_id  INTEGER REFERENCES Employees(employee_id),
	job_title   VARCHAR(255) NOT NULL
);

