class Passenger < ApplicationRecord
    has_many :trips, dependent: :nullify

    def average_rating
        passenger = Passenger.find_by(id: id)

        sum_rating = 0.0
        rates = passenger.trips.where.not(rating: nil)
        if rates.length == 0
            return 0
        else
            rates.each do |trip|
                sum_rating += trip.rating
            end
        end

        average = (sum_rating / rates.length)
        return average.round(2)
    end

    def total_spent
        passenger = Passenger.find_by(id: id)
        spent = 0.0
        trips = passenger.trips.where.not(cost: nil)

        # Return 0 if no trips driven
        if trips.length == 0
            return 0
        else
            trips.each do |trip|
                spent += trip.cost
            end
        end
        return spent.round(2)
    end
end
