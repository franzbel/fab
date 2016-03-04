class AddFlightHoursToAircrafts < ActiveRecord::Migration
  def change
    add_column :aircrafts, :flight_hours, :time, :default => 0
  end
end
