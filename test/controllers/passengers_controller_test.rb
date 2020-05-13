require "test_helper"

describe PassengersController do
  let (:passenger) {
    Passenger.create(name: "sample passenger", phone_number: "#123-345-4567")
  }
 
  describe "index" do
    it "can get the index path" do
      # Act
      get passengers_path
      
      # Assert
      must_respond_with :success
    end
    
    it "can get the root path" do
      # Act
      get root_path
      
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      # skip
      # Act
      get passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will redirect for an invalid passenger" do
      # skip
      # Act
      get passenger_path(-1)
      
      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      # skip
      
      # Act
      get new_passenger_path
      
      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      # skip
      
      # Arrange
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_number: "new passenger phone number",
        },
      }
      
      # Act-Assert
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.name).must_equal passenger_hash[:passenger][:name]
      expect(new_passenger.phone_number).must_equal passenger_hash[:passenger][:phone_number]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(new_passenger.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(passenger.id)
      
      # Assert
      must_respond_with :success
    end
    
    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(-1)
      
      # Assert
      must_redirect_to root_path
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a passenger, that would be a great
    #        thing to test.
    it "can update an existing passenger" do
      # Arrange
      passenger_hash = {
        passenger: {
          name: "updating this passenger",
          phone_number: "new passenger phone number",
        },
      }

      #create a new passenger using the let block
      passenger
      
      # Act-Assert
      expect {
        patch passenger_path(passenger[:id]), params: passenger_hash
      }.must_differ "Passenger.count", 0
      
      updated_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(updated_passenger.phone_number).must_equal passenger_hash[:passenger][:phone_number]
      expect(updated_passenger.name).must_equal passenger_hash[:passenger][:name]
      
      must_redirect_to passenger_path(updated_passenger.id)
    end
    
    it "will redirect to the root page if given an invalid id" do
      # Arrange
      passenger_hash = {
        passenger: {
          name: "updating this passenger",
          phone_number: "new passenger phone number",
        },
      }
      
      # Act-Assert
      expect {
        patch passenger_path(-1), params: passenger_hash
      }.must_differ "Passenger.count", 0
            
      must_redirect_to root_path
    end
  end

  describe "destroy" do
    it "deletes passenger when valid id is provided and redirects to root" do
      passenger  
      # Act-Assert
      expect {
        delete passenger_path(passenger[:id])
      }.must_differ "Passenger.count", -1
            
      must_redirect_to passengers_path
    end

    it "does not change anything when invalid id is provided and redirects to root" do
      passenger  
      # Act-Assert
      expect {
        delete passenger_path(-1)
      }.must_differ "Passenger.count", 0
            
      must_respond_with :not_found
    end
  end
end
