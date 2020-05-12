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
 
  def edit
    @trip = Trip.find_by(id: params[:id])
    if @trip.nil?
        head :not_found
        return
    end
end

  def update
    @trip= Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return 
    elsif @trip.update(
      date: params[:trip][:date],
      cost: params[:trip][:cost],
      rating: params[:trip][:rating],
      passenger_id: params[:trip][:passenger_id],
      driver_id: params[:trip][:driver_id],
    )
      redirect_to trip_path(@trip.id)
      return
    else
        render :edit
        return
    end
  end

  def update_trip_rating
  @trip= Trip.find_by(id: params[:id])
    if @trip.nil?
      head :not_found
      return 
    elsif @trip.update(
      rating: params[:rating_value],
    )
        redirect_to trip_path
        return
    else
        render :edit
        return
    end
  end 

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.destroy
      redirect_to root_path
      return
    else
      render :show
      return
    end
  end


end
