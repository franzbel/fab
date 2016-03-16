class AddColumnToTwelveMonthsInspections < ActiveRecord::Migration
  def change
    add_column :twelve_months_inspections, :aircraft_id, :integer
  end
end
