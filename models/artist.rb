require('pg')
require_relative('../db/sql_runner')
require_relative('album')


class Artist
  attr_accessor :name
  attr_reader :id

  def initialize( options )
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end 

  def save()
    sql = "INSERT INTO artists (name) VALUES ('#{@name}') RETURNING *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run(sql)
    return artists.map { |hash| Artist.new(hash) }
  end
  
  def self.delete_all()
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def find_albums
    sql = "SELECT * FROM albums WHERE artist_id = #{@id} ;"
    find_album = SqlRunner.run(sql)
    return find_album.map { |album| Album.new(album) }
  end



end