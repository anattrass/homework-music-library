require('pry-byebug')
require_relative('models/album')
require_relative('models/artist')
require_relative('models/song')

Song.delete_all()
Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Pink Floyd'})
artist2 = Artist.new({ 'name' => 'Michael Jackson'})

artist1.save()
artist2.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Dark Side of the Moon',
  'genre' => 'Prog Rock'
  })

album2 = Album.new({
  'artist_id' => artist2.id,
  'title' => 'Thriller',
  'genre' => 'Pop'
  })

album3 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Wish You Were Here',
  'genre' => 'Prog Rock'
  })

album1.save()
album2.save()
album3.save()

#album2.delete()

album1.title = 'The Wall'
album1.update()

song1 = Song.new({
  'album_id' => album3.id,
  'title' => 'Shine On You Crazy Diamond (Parts I–V)',
  'track_number' => 1,
  'song_length' => 13.32
  })
song2 = Song.new({
  'album_id' => album3.id,
  'title' => 'Welcome to the Machine',
  'track_number' => 2,
  'song_length' => 7.32
  })
song3 = Song.new({
  'album_id' => album3.id,
  'title' => 'Have A Cigar',
  'track_number' => 3,
  'song_length' => 5.24
  })
song4 = Song.new({
  'album_id' => album3.id,
  'title' => 'Wish You Were Here',
  'track_number' => 4,
  'song_length' => 5.40
  })
song5 = Song.new({
  'album_id' => album3.id,
  'title' => 'Shine On You Crazy Diamond (Parts VI–IX)',
  'track_number' => 5,
  'song_length' => 12.29
  })

song1.save()
song2.save()
song3.save()
song4.save()
song5.save()

songs = Song.all()

albums = Album.all()

artists = Artist.all()


binding.pry
nil