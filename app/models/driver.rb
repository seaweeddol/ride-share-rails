class Driver < ApplicationRecord
    has_many :trips, dependent: :nullify # nullify allows Driver to be deleted without deleting the Driver's trips
end
