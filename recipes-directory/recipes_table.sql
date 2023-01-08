CREATE TABLE "recipes" (
  "id" SERIAL PRIMARY KEY,
  "name" text,
  "cooking_time" int,
  "rating" int
);

INSERT INTO "recipes" ("name", "cooking_time", "rating") VALUES
('Lasagne', 40, 5),
('Spaghetti al pesto', 10, 4);