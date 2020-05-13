class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      redirect_to passenger_path
      return
    end
  end

  def new
    @passenger = Passenger.new 
  end

  def create
    @passenger = Passenger.new(passenger_params) 
    if @passenger.save 
      flash[:success] = "Passenger added successfully"
      redirect_to passenger_path(@passenger.id)
      return
    else # save failed :(
      flash.now[:error] = "Something happened. Passenger not added."
      render :new, status: :bad_request
      return
    end
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to root_path
      return
    end
  end

  def update
    @passenger= Passenger.find_by(id: params[:id])
    if @passenger.nil?
      redirect_to root_path
      return 
    elsif @passenger.update(
      name: params[:passenger][:name],
      phone_number: params[:passenger][:phone_number],
    )
      redirect_to passenger_path(@passenger.id)
      return
    else
      render :edit
      return
    end
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


  def passenger_params
    return params.require(:passenger).permit(:name, :phone_number)
  end
      
end
