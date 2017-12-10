require('pry-byebug')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screening.rb')

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

film1_screening = Screening.new({'film_id' => film1.id, 'time' => '15:00'})
film1_screening.save()
film2_screening = Screening.new({'film_id' => film2.id, 'time' => '23:00'})
film2_screening.save()
film3_screening = Screening.new({'film_id' => film3.id, 'time' => '18:30'})
film3_screening.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => film1_screening.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer1.id, 'screening_id' => film2_screening.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => film2_screening.id})
ticket3.save()
ticket4 = Ticket.new({'customer_id' => customer2.id, 'screening_id' => film3_screening.id})
ticket4.save()
ticket5 = Ticket.new({'customer_id' => customer3.id, 'screening_id' => film1_screening.id})
ticket5.save()
ticket6 = Ticket.new({'customer_id' => customer4.id, 'screening_id' => film1_screening.id})
ticket6.save()
ticket7 = Ticket.new({'customer_id' => customer5.id, 'screening_id' => film1_screening.id})
ticket7.save()
ticket8 = Ticket.new({'customer_id' => customer5.id, 'screening_id' => film1_screening.id})
ticket8.save()

binding.pry
nil
