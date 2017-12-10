require_relative('../db/sql_runner.rb')

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_f()
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first()
    @id = customer['id'].to_i()
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def films()
    sql = "SELECT films.title
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1;"
    values = [@id]
    films_hashes = SqlRunner.run(sql, values)
    result = films_hashes.map { |film_hash| Film.new(film_hash)}
    return result
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    customer_hashes = SqlRunner.run(sql)
    result = customer_hashes.map { |customer_hash| Customer.new(customer_hash) }
    return result
  end

  def Customer.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer_hash = SqlRunner.run(sql, values).first()
    customer = Customer.new(customer_hash)
    return customer
  end

  def Customer.delete_all()
    SqlRunner.run("DELETE FROM customers;")
  end

end
