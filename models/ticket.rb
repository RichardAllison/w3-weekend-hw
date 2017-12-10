require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader(:id, :customer_id, :film_id)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @customer_id = options['customer_id'].to_i() if options['customer_id']
    @film_id = options['film_id'].to_i() if options['film_id']
  end

  def sell_ticket()
    customer = Customer.find(@customer_id)
    film = Film.find(@film_id)
    customer.funds -= film.price if customer.funds >= film.price
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    values = [customer.funds, @customer_id]
    SqlRunner.run(sql, values)
  end

  def save()
    customer = Customer.find(@customer_id)
    film = Film.find(@film_id)
    if customer.funds >= film.price
      sell_ticket()
      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
      values = [@customer_id, @film_id]
      ticket = SqlRunner.run(sql, values).first()
      @id = ticket['id']
    end
  end

  def find()
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Ticket.all()
    sql = "SELECT * FROM tickets;"
    ticket_hashes = SqlRunner.run(sql)
    result = ticket_hashes.map { |ticket_hash| Ticket.new(ticket_hash)}
    return result
  end

  def Ticket.delete_all()
    SqlRunner.run("DELETE FROM tickets;")
  end

end
