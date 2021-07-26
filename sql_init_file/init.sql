CREATE DATABASE test_database;
\с test_database
CREATE TABLE customers
(
    Id SERIAL PRIMARY KEY,
    FirstName CHARACTER VARYING(30),
    LastName CHARACTER VARYING(30),
    Email CHARACTER VARYING(30),
    Age INTEGER
);
INSERT INTO customers (Id, FirstName, LastName,Email,Age) VALUES
    (1, 'Valeriy', 'Emelyanov', 'Emelyanov@mail.com', 10),
    (2, 'Evgeniy', 'Petrov', 'Petrov@gmail.com', 33),
    (3, 'Sergey', 'Ivanov', 'Ivanov@ya.ru', 66);