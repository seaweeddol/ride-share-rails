class PassengersController < ApplicationController
    def index
        @passengers = Passenger.all
    end

    def show
        passenger_id = params[:id]
        @passenger = Passenger.find_by(id: passenger_id)
        if @passenger.nil?
            head :not_found
            return
        end
    end

    def new
    end

    def destroy
        @passenger = Passenger.find_by(id: params[:id])
  
        if @passenger.nil?
          head :not_found
          return
        elsif @passenger.destroy
          redirect_to passengers_path
          return
        else
          render :show
          return
        end
      end
      
end
