class AddFlightHoursToComponents < ActiveRecord::Migration
  def change
    add_column :components, :flight_hours, :time, :default => 0
  end
end
