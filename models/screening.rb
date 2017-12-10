require_relative('../db/sql_runner.rb')

class Screening

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @film_id = options['film_id'].to_i() if options['film_id']
    @time = options['time']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, time) VALUES ($1, $2) RETURNING id;"
    values = [@film_id, @time]
    screening = SqlRunner.run(sql, values).first()
    @id = screening['id']
  end

  def update()
    sql = "UPDATE screenings SET (film_id, time) = ($1, $2) WHERE id = $3;"
    values = [@film_id, @time, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.name, customers.funds
    FROM screenings
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    INNER JOIN customers
    ON tickets.customer_id = customers.id
    WHERE screenings.film_id = $1"
    values = [@id]
    customers_hash = SqlRunner.run(sql, values)
    result = customers_hash.map { |customers_hash| Customer.new(customers_hash)}
    return result
  end

  def customer_count()
    customers.count()
  end

  def Screening.all()
    sql = "SELECT * FROM screenings"
    screening_hashes = SqlRunner.run(sql)
    result = screening_hashes.map { |screening_hash| Screening.new(screening_hash) }
    return result
  end

  def Screening.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    screening_hash = SqlRunner.run(sql, values).first()
    screening = Customer.new(screening_hash)
    return screening
  end

  def Screening.find_film(id)
    sql = "SELECT title, price
    FROM films
    INNER JOIN screenings
    ON films.id = screenings.film_id
    WHERE screenings.id = $1"
    values = [id]
    film_hash = SqlRunner.run(sql, values).first()
    film = Film.new(film_hash)
    return film
  end

  def Screening.delete_all()
    SqlRunner.run("DELETE FROM screenings;")
  end

end
