require('pg')
require_relative('../db/sql_runner')
require_relative('song')

class Album
  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize( options )
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ('#{@title}', '#{@genre}', #{@artist_id}) RETURNING *;"

    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def update
    sql = "UPDATE albums SET (title, genre, artist_id) = ('#{@title}', '#{@genre}', #{@artist_id}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    return unless @id
    sql = "DELETE FROM albums WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def artist()
      sql = "SELECT * FROM artists WHERE id = #{@artist_id};"
      result = SqlRunner.run(sql)
      artist = Artist.new(result[0])
      return artist
  end

  def list_songs
    sql = "SELECT * FROM songs WHERE album_id = #{@id} ;"
    list_songs = SqlRunner.run(sql)
    return list_songs.map { |song| Song.new(song) }
  end

    def album_length
        sql = "SELECT SUM(song_length) FROM songs;"
        return SqlRunner.run(sql)
    end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def self.delete_all()
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end
  
end