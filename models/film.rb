require_relative('../db/sql_runner.rb')

class Film

  attr_reader(:id)
  attr_accessor(:title, :price)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title = options['title']
    @price = options['price'].to_i()
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id'].to_i()
  end

  def Film.all()
    sql = "SELECT * FROM films;"
    film_hashes = SqlRunner.run(sql)
    result = film_hashes.map { |film_hash| Film.new(film_hash)}
    return result
  end

  def Film.delete_all()
    SqlRunner.run("DELETE FROM films;")
  end

end
