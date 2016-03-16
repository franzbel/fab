class AddColumnToAircrafts < ActiveRecord::Migration
  def change
    add_column :aircrafts, :beginning_time, :date
  end
end
