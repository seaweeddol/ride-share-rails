class Trip < ApplicationRecord
    belongs_to :passenger
    belongs_to :driver

    # make this a class method instead of instance method
    def self.new_trip(passenger_id)
        # business logic to set random cost & choose driver & trip date
        return {
            driver_id: Trip.choose_available_driver, 
            passenger_id: passenger_id, # send data as a parameter when calling it from the controller
            date: Time.now.to_s,
            rating: nil,
            cost: Trip.random_cost
        }
    end

    def self.choose_available_driver
        return Driver.find_by(available:true).id
    end

    def self.random_cost
      return (1..5000).to_a.sample
    end
end
