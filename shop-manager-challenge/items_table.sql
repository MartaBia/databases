-- CREATING TABLES WORKING

CREATE TABLE "orders" (
  "id" SERIAL PRIMARY KEY,
  "customer_name" text,
  "date" int
);

CREATE TABLE "items" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "unit_price" int,
  "quantity" int,
  "order_id" int,
  constraint fk_order foreign key("order_id")
    references "orders"("id")
    on delete cascade
);

INSERT INTO "orders" ("customer_name", "date") VALUES('Marta Bianchini', '9/01/2023');
INSERT INTO "orders" ("customer_name", "date") VALUES('Name Surname', '5/01/2023');
INSERT INTO "orders" ("customer_name", "date") VALUES('Name_2 Surname_2', '3/01/2023');

INSERT INTO "items" ("name", "unit_price", "quantity", "order_id") VALUES('Black Trousers', 30, 52, 1);
INSERT INTO "items" ("name", "unit_price", "quantity", "order_id") VALUES('Yellow T-shirt', 20, 23, 1);
INSERT INTO "items" ("name", "unit_price", "quantity", "order_id") VALUES('Nike Trainers', 100, 12, 2);
INSERT INTO "items" ("name", "unit_price", "quantity", "order_id") VALUES('Green Bag', 80, 69, 2);
INSERT INTO "items" ("name", "unit_price", "quantity", "order_id") VALUES('Blue Top', 20, 32, 3);