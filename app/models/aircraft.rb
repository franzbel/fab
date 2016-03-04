class Aircraft < ActiveRecord::Base
  has_many :systems
  has_many :flight_sheets
end
