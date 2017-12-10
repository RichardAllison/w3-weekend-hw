require('pry-byebug')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({'name' => 'Richard', 'funds' => '50'})
customer1.save()
customer2 = Customer.new({'name' => 'Andrew', 'funds' => '150'})
customer2.save()
customer3 = Customer.new({'name' => 'Jonathan', 'funds' => '200'})
customer3.save()
customer4 = Customer.new({'name' => 'Simon', 'funds' => '30'})
customer4.save()
customer5 = Customer.new({'name' => 'Brad', 'funds' => '20'})
customer5.save()

customer1.funds = '60'
customer1.update

film1 = Film.new({'title' => 'Star Wars Episode VIII: The Last Jedi', 'price' => '15.5'})
film1.save()
film2 = Film.new({'title' => 'Justice League', 'price' => '8.9'})
film2.save()
film3 = Film.new({'title' => 'It\'s a Wonderful Life', 'price' => '7.9'})
film3.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film1.id})
ticket5.save()
ticket6 = Ticket.new({'customer_id' => customer4.id, 'film_id' => film1.id})
ticket6.save()
ticket7 = Ticket.new({'customer_id' => customer5.id, 'film_id' => film1.id})
ticket7.save()

binding.pry
nil
