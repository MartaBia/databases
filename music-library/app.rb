require_relative 'lib/database_connection.rb' # Probably to cancel?
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# DatabaseConnection.connect('music_library')

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# puts "Artists:"
# artist_repository.all.each do |artist|
#   puts "#{artist.id} - #{artist.name} - #{artist.genre}"
# end

# puts "Albums:"
# album_repository.all.each do |album|
#   puts "#{album.id} - #{album.title}, #{album.release_year} #{album.artist_id}"
# end

# artist = artist_repository.find(1)
# puts artist.name

# album = album_repository.find(3)
# puts "#{album.title}, #{album.release_year}, artist id: #{album.artist_id}"

class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run

    @io.puts "Welcome to the music library manager!"
    @io.puts "What would you like to do?"
    @io.puts "1 - List all albums"
    @io.puts "2 - List all artists"

    user_input = @io.gets.chomp
    if user_input == 1
      lists_albums
    else
      lists_artists
    end
  end

  private

  def lists_albums
    album_repository.all.each do |album|
      puts "* #{album.id} - #{album.title}"
    end
  end

  def lists_artists
    artist_repository.all.each do |artist|
      puts "#{artist.id} - #{artist.name} - #{artist.genre}"
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end


# Expected output:

# $ ruby app.rb

# Welcome to the music library manager!

# What would you like to do?
#  1 - List all albums
#  2 - List all artists

# Enter your choice: 1
# [ENTER]

# Here is the list of albums:
#  * 1 - Doolittle
#  * 2 - Surfer Rosa
#  * 3 - Waterloo
#  * 4 - Super Trouper
#  * 5 - Bossanova
#  * 6 - Lover
#  * 7 - Folklore
#  * 8 - I Put a Spell on You
#  * 9 - Baltimore
#  * 10 -	Here Comes the Sun
#  * 11 - Fodder on My Wings
#  * 12 -	Ring Ring