require('pry-byebug')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/ticket.rb')

customer1 = Customer.new({'name' => 'Richard', 'funds' => 50})
customer1.save()

film1 = Film.new({'title' => 'Star Wars Episode VIII: The Last Jedi', 'price' => 12})
film1.save()

binding.pry
nil
