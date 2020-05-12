class Driver < ApplicationRecord
    has_many :trips, dependent: :nullify # nullify allows Driver to be deleted without deleting the Driver's trips

    def average_rating
        driver = Driver.find_by(id: id)

        sum_rating = 0.0
        rates=  driver.trips.where.not(rating: nil)
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

    def total_revenue
        driver = Driver.find_by(id: id)
        revenue = 0.0
        trips =  driver.trips.where.not(cost: nil)

        # Return 0 if no trips driven
        if trips.length == 0
            return 0
        else
            trips.each do |trip|
            revenue += trip.cost
            end
        end
        # Return 0 if revenue <= 1.65 (flat cost) per trip, otherwise run revenue formula
        if revenue > (1.65 * trips.length)
            total_revenue = (revenue - (1.65 * trips.length))* 0.8
            return total_revenue.round(2)
        else 
            return 0
        end
    end
end
