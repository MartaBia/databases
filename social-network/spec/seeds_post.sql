TRUNCATE TABLE accounts RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (email_address, username) VALUES ('marta.bianchini@domain.com', 'user_1');
INSERT INTO accounts (email_address, username) VALUES ('name.surname@domain.com', 'user_2');

INSERT INTO posts (title, content, views_count, account_id) VALUES ('Title_1', 'Some content', 3, '1');
INSERT INTO posts (title, content, views_count, account_id) VALUES ('Title_2', 'Some other content', 5, '1');
INSERT INTO posts (title, content, views_count, account_id) VALUES ('Title_3', 'Some other content 2', 1, '2');