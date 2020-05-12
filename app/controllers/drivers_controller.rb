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

    def new
      @driver = Driver.new 
    end

    def create
      @driver = Driver.new(driver_params) 
      if @driver.save 
        flash[:success] = "Driver added successfully"
        redirect_to driver_path(@driver.id)
        return
      else # save failed :(
        flash.now[:error] = "Something happened. Driver not added."
        render :new, status: :bad_request
        return
      end
    end

    def edit
      @driver = Driver.find_by(id: params[:id])
      if @driver.nil?
          head :not_found
          return
      end
  end

  def update
      @driver= Driver.find_by(id: params[:id])
      if @driver.nil?
          head :not_found
          return 
      elsif @driver.update(
          name: params[:driver][:name],
          vin: params[:driver][:vin],
          available: params[:driver][:available]
      )
          redirect_to driver_path(@driver.id)
          return
      else
          render :edit
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

    def update_driver_status
      @driver= Driver.find_by(id: params[:id])
      if @driver.available == false || @driver.available == nil
          if @driver.update(
             available: true
          ) 
              redirect_to request.referrer
              return
          end
        else
          if @driver.update(
            available: false
          ) 
          redirect_to request.referrer
          return
        end
      end
    end

    def driver_params
      return params.require(:driver).permit(:name, :vin, :available)
    end
end

