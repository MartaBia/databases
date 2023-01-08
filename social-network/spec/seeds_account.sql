TRUNCATE TABLE accounts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email_address, username) VALUES ('marta.bianchini@domain.com', 'user_1');
INSERT INTO accounts (email_address, username) VALUES ('name.surname@domain.com', 'user_2');