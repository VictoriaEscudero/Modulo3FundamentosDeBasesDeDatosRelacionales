-- Se crean las tablas User, Currency, Transaction

CREATE TABLE User (
user_id INT PRIMARY KEY NOT NULL,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
balance DECIMAL(10,2)
);

CREATE TABLE Currency (
currency_id INT PRIMARY KEY NOT NULL,
currency_name VARCHAR(50) NOT NULL,
currency_symbol VARCHAR(10) NOT NULL
);

/* Esta tabla se crea al final, porque tiene referencias de las dos tablas anteriores*/
CREATE TABLE Transaction (
transaction_id INT PRIMARY KEY NOT NULL,
sender_user_id INT NOT NULL,
receiver_user_id INT NOT NULL,
transaction_currency_id INT NOT NULL,
FOREIGN KEY (sender_user_id) REFERENCES User(user_id),
FOREIGN KEY (receiver_user_id) REFERENCES User(user_id),
FOREIGN KEY (transaction_currency_id) REFERENCES Currency(currency_id),
amount DECIMAL(10,2) NOT NULL,
transaction_date DATE
);


-- Se insertan datos dentro de las tablas

INSERT INTO User (user_id, name, email, password, balance)
VALUES 
(1, 'Victoria Escudero','victoria@gmail.com','Usuario123',1000),
(2, 'Romina Jorquera','romina@gmail.com','Usuario124',200),
(3, 'Oscar Andrade','oscar@gmail.com','Usuario125',300),
(4, 'Raul Silva','raul@gmail.com','Usuario126',400),
(5, 'Consuelo Saavedra','consuelo@gmail.com','Usuario127',500),
(6, 'Camila Fuentes','camila@gmail.com','Usuario128',600),
(7, 'Sandra Torres','sandra@gmail.com','Usuario129',700),
(8, 'Camilo Gonzalez','camilo@gmail.com','Usuario1230',800),
(9, 'Fernando Urrutia','fernando@gmail.com','Usuario1231',900),
(10, 'Nicole Sanchez','nicole@gmail.com','Usuario1232',100);

INSERT INTO Currency (currency_id, currency_name, currency_symbol)
VALUES 
(1,'Peso chileno', 'CLP$'),
(2,'Dolar Estadounidense', 'US$'),
(3,'Euro', '€');

INSERT INTO Transaction (transaction_id, sender_user_id, receiver_user_id, 
transaction_currency_id, amount, transaction_date)
VALUES
(1,1,2,1,12350.00,'2024-02-20'),
(2,2,1,2,12.58,'2024-02-24'),
(3,1,2,1,7500.00,'2024-02-27'),
(4,1,2,3,800.00,'2024-02-28'),
(5,1,2,2,123.50,'2024-02-29')
(6,3,2,1,2350.00,'2024-03-04'),
(7,6,3,2,12.07,'2024-03-14'),
(8,5,4,1,15000.00,'2024-03-21'),
(9,7,9,3,90.00,'2024-03-28'),
(10,10,8,2,12.50,'2024-03-30');


-- Comienzan las consultas

/* Consulta para obtener el nombre de la moneda elegida por un usuario específico, en este caso, el usuario número 7*/
SELECT u.name AS Nombre,
c.currency_name AS Divisa,
c.currency_symbol AS Símbolo
FROM User AS u
JOIN transaction AS t ON u.user_id = t.sender_user_id
OR u.user_id = t.receiver_user_id
JOIN currency AS c ON t.transaction_currency_id = c.currency_id
WHERE u.user_id = 7;

/* Consulta para obtener todas las transacciones registradas */
SELECT * FROM Transaction;

/* Consulta para obtener todas las transacciones realizadas por un usuario específico */
SELECT * FROM Transaction AS t
WHERE t.receiver_user_id = 1 OR t.sender_user_id = 1;

/* Sentencia DML para modificar el campo correo electrónico de un usuario específico, en este caso, se cambia el email del usuario número 2 */
UPDATE User
SET email = 'rjorquera@gmail.com'
WHERE user_id = 2;

/* Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) */
DELETE FROM Transaction
WHERE transaction_id = 3;
