CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  genre text,
  release_year int
);

INSERT INTO "movies" ("id", "title", "genre", "release_year") VALUES
(1, 'Interstellar', 'Sci-fi', 2014),
(2, 'Jojo Rabbit', 'Comedy', 2019);