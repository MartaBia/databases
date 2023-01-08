# Artists Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'POP');
-- INSERT INTO artists (name, genre) VALUES ('Taylor Swift', 'POP');
-- INSERT INTO artists (name, genre) VALUES ('Oasis', 'Alternative');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 music_library < seeds_albums.sql
```

## 3. Define the class names

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/artist.rb)
class Artist
end

# Repository class
# (in lib/artist_repository.rb)
class ArtistRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: artists

# Model class
# (in lib/artist.rb)

class Artist
  attr_accessor :id, :name, :genre
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: artists

# Repository class
# (in lib/artists_repository.rb)

class ArtistsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1;

    # Returns a single Artist object.
  end

  # Insert a new artist record
  # Takes an artist object in the argument
  def create(artist)
    # INSERT INTO artists (artist.name, artists.genre) VALUES('artist_name', 'artist_genre');

    # Doesn't return anything, only creates the record
  end

  # Delete an artist record
  # Take the ID as a parameter
  def delete(id)
    # DELETE FROM artists WHERE id = $1; 

    # Returns nothing
  end

  # Upfates and artist object
  # Takes an artist object with updated fields
  def update(artist)
    # UPDATE [artist.name] set 
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all artists

repo = ArtistRepository.new

artists = repo.all

artists.length # =>  2

artist[0].id # =>  1
artist[0].name # =>  'Pixies'
artist[0].genre # =>  'Rock'

artist[1].id # =>  2
artist[1].name # =>  'ABBA'
artist[1].genre # =>  'POP'

# 2
# Get a single artists

repo = ArtistRepository.new

artist = repo.find(1)

artist.id # =>  1
artist.name # =>  'Pixies'
artist.genre # =>  'Rock'

# 2
# Get another single artists

repo = ArtistRepository.new

artist = repo.find(2)

artist.id # =>  2
artist.name # =>  'ABBA'
artist.genre # =>  'POP'

# 3
# Create a new artists

repo = ArtistRepository.new

artist = Artist.new
artist.name = 'Beatles'
artist.genre = 'POP'

repo.create(artist) # => returns nothing

artists = repo.all

last_artist = artists.last
last_artist.name # => "Beatles"
last_artist.genre # => "POP"

#4 
# Deletes one artist record
repo = ArtistRepository.new

id_to_delete = 1

repo.delete(id_to_delete)

all_artists = repo.all
all_artists.length # => 1
all_artists.first.id # => '2'

#5
# Updates an artist record
repo = ArtistRepository.new

artist = repo.find(1)

artist.name = 'Something else'
artist.genre = 'Disco'

repo.update(artist)

all_artists = repo.all
expect(artist.name) # => 'Something else'
expect(artist.genre) # => 'Disco'


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/artist_repository_spec.rb

def reset_artists_table
  seed_sql = File.read('spec/seeds_artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_artists_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
