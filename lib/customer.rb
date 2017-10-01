require_relative "./rental"
require_relative "./movie"

class Customer
  attr_reader :name
  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      this_amount = 0

      # determine amounts for each line
      case element.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (element.days_rented - 2) * 1.5 if element.days_rented > 2
      when Movie::NEW_RELEASE
        this_amount += element.days_rented * 3
      when Movie::CHILDRENS
        this_amount += 1.5
        this_amount += (element.days_rented - 3) * 1.5 if element.days_rented > 3
      end

      # add frequent renter points
      frequent_renter_points += 1
      # add bonus for a two day new release rental
      if element.movie.price_code == Movie::NEW_RELEASE && element.days_rented > 1
        frequent_renter_points += 1
      end
      # show figures for this rentals
      result += "\t" + element.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer lines
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end

# gone_with_the_wind = Movie.new("Gone With The Wind", Movie::REGULAR)
# moana = Movie.new("Moana", Movie::CHILDRENS)
# rental1 = Rental.new(gone_with_the_wind, 2)
# rental2 = Rental.new(gone_with_the_wind, 3)
# rental3 = Rental.new(moana, 1)
# rental4 = Rental.new(moana, 4)
# customer_johnny = Customer.new("Johnny")
# customer_mary = Customer.new("Mary")
# customer_alex = Customer.new("Alex")
# customer_johnny.add_rental(rental1)
# customer_johnny.add_rental(rental2)
# customer_mary.add_rental(rental3)
# customer_alex.add_rental(rental4)
# p customer_johnny.name
# puts customer_johnny.statement
# p customer_mary.name
# puts customer_mary.statement
# p customer_alex.name
# puts customer_alex.statement