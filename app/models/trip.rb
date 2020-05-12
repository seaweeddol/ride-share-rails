class Trip < ApplicationRecord
    belongs_to :passenger
    belongs_to :driver

    def self.new_trip(passenger_id)
        parameters = {
            driver_id: Trip.choose_available_driver, 
            passenger_id: passenger_id,
            date: Time.now.to_s,
            rating: nil,
            cost: Trip.random_cost
        }
        trip = Trip.new(parameters)
        trip.save
  
        return trip
    end

    def self.choose_available_driver
        driver = Driver.find_by(available:true)
        Driver.update(driver.id, :available => false)      
        return driver.id
    end

    def self.random_cost
      return (1..5000).to_a.sample
    end
  
end
