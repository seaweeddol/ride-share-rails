class DriversController < ApplicationController
    def index
      @drivers = Driver.all
    end
    
    def show
      driver_id = params[:id]
      @driver = Driver.find_by(id: driver_id)
      if @driver.nil?
        head :not_found
        return
      end
    end

    def destroy
      @driver = Driver.find_by(id: params[:id])
      # @driver.trips.each do |trip|
      #   trip.driver_id = placeholder_driver
      #  end

      if @driver.nil?
        head :not_found
        return
      elsif @driver.destroy
        redirect_to drivers_path
        return
      else
        render :show
        return
      end
    end
end

