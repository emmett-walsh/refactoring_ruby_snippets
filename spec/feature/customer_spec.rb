require 'customer'
require 'rspec'

describe 'statement' do
  let(:customer_johnny) { Customer.new("Johnny") }

  context 'for a single rental' do
    context 'of a regular movie' do
      let(:regular_movie) { Movie.new("Gone With The Wind", Movie::REGULAR) }

      context 'for 2 days or fewer' do
        let(:short_regular_rental) { Rental.new(regular_movie, 2) }

        it 'costs a flat rate of 2 and earns 1 frequent renter point' do
          customer_johnny.add_rental(short_regular_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Gone With The Wind" + "\t" + "2" + "\n" +
            "Amount owed is 2\n" +
            "You earned 1 frequent renter points"
          )
        end
      end

      context 'for more than 2 days' do
        let(:long_regular_rental) { Rental.new(regular_movie, 3) }

        it 'costs 2 plus 1.5 per each successive day over 2, and earns 1 frequent renter point' do
          customer_johnny.add_rental(long_regular_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Gone With The Wind" + "\t" + "3.5" + "\n" +
            "Amount owed is 3.5\n" +
            "You earned 1 frequent renter points"
          )
        end
      end
    end

    context 'of a new release movie' do
      let(:new_release_movie) { Movie.new("Moana", Movie::NEW_RELEASE) }

      context 'for 1 day' do
        let(:new_release_short_rental) { Rental.new(new_release_movie, 1) }

        it 'costs 3 and earns 1 frequent renter point' do
          customer_johnny.add_rental(new_release_short_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Moana" + "\t" + "3" + "\n" +
            "Amount owed is 3\n" +
            "You earned 1 frequent renter points"
          )
        end
      end

      context 'for more than 1 day' do
        let(:new_release_long_rental) { Rental.new(new_release_movie, 3) }

        it 'costs 3 per day and earns 2 frequent renter point' do
          customer_johnny.add_rental(new_release_long_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Moana" + "\t" + "9" + "\n" +
            "Amount owed is 9\n" +
            "You earned 2 frequent renter points"
          )
        end
      end
    end

    context 'of a children\'s movie' do
      let(:childrens_movie) { Movie.new("Captain Underpants", Movie::CHILDRENS) }

      context 'for 3 days or fewer' do
        let(:short_childrens_rental) { Rental.new(childrens_movie, 3) }

        it 'costs a flat rate of 1.5 and earns 1 frequent renter point' do
          customer_johnny.add_rental(short_childrens_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Captain Underpants" + "\t" + "1.5" + "\n" +
            "Amount owed is 1.5\n" +
            "You earned 1 frequent renter points"
          )
        end
      end

      context 'for more than 3 days' do
        let(:long_childrens_rental) { Rental.new(childrens_movie, 4) }

        it 'costs 1.5 plus 1.5 per each successive day over 3, and earns 1 frequent renter point' do
          customer_johnny.add_rental(long_childrens_rental)
          expect(customer_johnny.statement).to eq(
            "Rental Record for Johnny\n" +
            "\t" + "Captain Underpants" + "\t" + "3.0" + "\n" +
            "Amount owed is 3.0\n" +
            "You earned 1 frequent renter points"
          )
        end
      end
    end
  end

  context 'for more than one rental' do
    let(:regular_movie) { Movie.new("Gone With The Wind", Movie::REGULAR) }
    let(:new_release_movie) { Movie.new("Moana", Movie::NEW_RELEASE) }
    let(:long_regular_rental) { Rental.new(regular_movie, 3) }
    let(:new_release_long_rental) { Rental.new(new_release_movie, 3) }

    it 'summarises costs and frequent renter points for all rentals' do
      customer_johnny.add_rental(long_regular_rental)
      customer_johnny.add_rental(new_release_long_rental)
      expect(customer_johnny.statement).to eq(
        "Rental Record for Johnny\n" +
        "\t" + "Gone With The Wind" + "\t" + "3.5" + "\n" +
        "\t" + "Moana" + "\t" + "9" + "\n" +
        "Amount owed is 12.5\n" +
        "You earned 3 frequent renter points"
      )
    end
  end
end
