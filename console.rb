require('pry-byebug')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Customer.delete_all
Film.delete_all

customer1 = Customer.new({'name' => 'Richard', 'funds' => 50})
customer1.save()

film1 = Film.new({'title' => 'Star Wars Episode VIII: The Last Jedi', 'price' => 11})
film1.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

binding.pry
nil
