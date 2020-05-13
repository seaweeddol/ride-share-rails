require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "name1", vin: "2564633", available: true
  }
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      get drivers_path
      
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no drivers saved" do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing valid driver" do
        # Act
        get driver_path(driver.id)
        
        # Assert
        must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
        # Act
        get driver_path(99999)
        
        # Assert
        must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
        # Act
        get new_driver_path
        
        # Assert
        must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      
      # Arrange
      driver_hash = {
        driver: {
          name: "new driver",
          vin: "new driver vin",
          available: true
        },
      }
      
      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      
      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.name).must_equal driver_hash[:driver][:name]
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(new_driver.available).must_equal driver_hash[:driver][:available]

      
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver.id)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      driver_hash = {
        driver: {
          name: "new driver",
          vin: nil,
          available: false
        },
      }
      
      # Act-Assert
      expect {
        post drivers_path, params: driver_hash
      }.must_differ "Driver.count", 0
            
      must_respond_with :bad_request
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      get edit_driver_path(driver.id)
      
      # Assert
      must_respond_with :success
    end
      

    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-1)
      
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data

      # Act-Assert
      # Ensure that there is no change in Driver.count

      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      # Check that the controller redirected the user
      driver_hash = {
        driver: {
          name: "random driver",
          vin: "some vin number",
          available: true,
        },
      }

      driver 
      
      # Act-Assert
      expect {
        patch driver_path(driver[:id]), params: driver_hash
      }.must_differ "Driver.count", 0

      updated_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(updated_driver.name).must_equal driver_hash[:driver][:name]
      expect(updated_driver.vin).must_equal driver_hash[:driver][:vin]
      expect(updated_driver.available).must_equal driver_hash[:driver][:available]
      
      must_redirect_to driver_path(updated_driver.id)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      driver_hash = {
        driver: {
          name: "updating this driver",
          vin: "9878",
          available: true
        },
      }

      driver 
      
      # Act-Assert
      expect {
        patch driver_path(97777), params: driver_hash
      }.must_differ "Driver.count", 0
            
      must_respond_with :not_found
    end

    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
      # Note: This will not pass until ActiveRecord Validations lesson
      # Arrange
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      # Set up the form data so that it violates Driver validations

      driver_hash = {
        driver: {
          name: nil,
          vin: nil,
          available: false
        },
      }
       
      driver
      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(driver[:id]), params: driver_hash
      }.must_differ "Driver.count", 0

      # Assert
      # Check that the controller redirects
      must_respond_with :success
    end
  end

  describe "toggle available and not available driver" do
    it "changes available to false if it is true" do
      # Arrange
      driver
      
      # Act-Assert
      expect {
        patch update_driver_status_path(driver[:id])
      }.must_differ "Driver.count", 0
      
      updated_driver = Driver.find_by(id: driver[:id])
      expect(updated_driver.available).must_equal false
      
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      driver  
      # Act-Assert
      expect {
        delete driver_path(driver[:id])
      }.must_differ "Driver.count", -1
            
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      driver  
      # Act-Assert
      expect {
        delete driver_path(-1)
      }.must_differ "Driver.count", 0
            
      must_respond_with :not_found
    end
  end
end
