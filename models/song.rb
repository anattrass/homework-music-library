require('pg')
require_relative('../db/sql_runner')

class Song
  attr_accessor :title, :track_number, :song_length, :album_id
  attr_reader :id

  def initialize( options )
    @title = options['title']
    @track_number = options['track_number'].to_i
    @song_length = options['song_length'].to_f
    @id = options['id'].to_i if options['id']
    @album_id = options['album_id'].to_i
  end

  def save
    sql = "INSERT INTO songs (title, track_number, song_length, album_id) VALUES ('#{@title}', #{@track_number}, #{@song_length}, #{@album_id}) RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM songs;"
    songs = SqlRunner.run(sql)
    return songs.map { |song| Song.new(song) }
  end

  def self.delete_all()
    sql = "DELETE FROM songs;"
    SqlRunner.run(sql)
  end

  def album()
    sql = "SELECT * FROM albums WHERE id = #{@album_id};"
    result = SqlRunner.run(sql)
    album = Album.new(result[0])
    return album
  end

end
