class TripsController < ApplicationController
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
        head :not_found
        return
    end
  end

  def create
    if params[:passenger_id]
      trip = Trip.new_trip(params[:passenger_id])
      redirect_to trip_path(trip.id)
    else
      # if create fails, show an error message on the passenger page?
      redirect_to passenger_path(params[:passenger_id])
    end
  end

end
