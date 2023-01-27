require_relative '../app'
require 'album_repository'
require 'artist_repository'

RSpec.describe Application do
  xit "print the header" do
    io = double :io
    album_repository = AlbumRepository.new
    artist_repository = ArtistRepository.new
    expect(io).to receive(:puts).with("Welcome to the music library manager!")
    expect(io).to receive(:puts).with("What would you like to do?")
    expect(io).to receive(:puts).with("1 - List all albums")
    expect(io).to receive(:puts).with("2 - List all artists")
    expect(io).to receive(:puts).with("Enter your choice: ")
    expect(io).to receive(:gets).and_return("1")

    app = Application.new("music_library", io, album_repository, artist_repository)
    app.run
  end
ends