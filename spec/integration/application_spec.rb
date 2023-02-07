require "spec_helper"
require "rack/test"
require_relative '../../app'
require_relative '../../lib/album_repository.rb'
require_relative '../../lib/artist_repository.rb'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /albums" do
    it "returns a list of albums with hyperlinks to the albums" do
      response = get('/albums')


      expect(response.body).to include('<a href="/albums/1">')
    end
  end

  context "GET albums/:id" do
    it "returns the album within a HTML page" do
      response = get(
        '/albums/2'
      )

      expect(response.status).to eq(200)
    end
  end


  context 'GET /artists' do
    it "should return all artists" do
      response = get('/artists')

      expect(response.status).to eq(200)
    end
  end

  context 'GET /artists/:id' do
    it "should return a page for the given artist" do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include("Artist: Pixies")
      expect(response.body).to include("Genre: Rock")
    end
  end

  context 'POST /albums' do
    it "should create a new album" do
      response = post(
        '/albums',
        title: 'OK Computer',
        release_year: '1997',
        artist_id: '1'
      )

      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your album has been added!</p>')

      all_albums = get('/albums')

      expect(all_albums.body).to include('OK Computer')
    end
  end

  context 'POST /artists' do
    it 'creates a new artist' do
      response = post(
        '/artists',
        name: 'Disclosure',
        genre: 'Dance'
      )
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your artist was added successfully</p>')
    end
  end

  context 'GET /albums/new' do
    it 'returns the form page' do
      response = get('/albums/new')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an album</h1>')

      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context 'POST /albums' do
    it 'returns a sucess page' do
      response = post(
        '/albums',
        title: "Settle",
        release_year: '2013',
        artist_id: '6'
      )

      expect(response.status).to eq 200
      expect(response.body).to include('<p>Your album has been added!</p>')
    end

    it 'responds with 400 status if parameters are invalid' do
      response = post(
        '/albums',
        title: nil,
        release_year: nil
      )

      expect(response.status).to eq(400)
    end
  end

  context 'GET /artists/new' do
    it 'returns the form page' do
      response = get('/artists/new')
      
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Add a new artist</h1>')
      expect(response.body).to include('<form action="/artists" method="POST">')
    end
  end
end
