class AddColumnToSecondInspections < ActiveRecord::Migration
  def change
    add_column :second_inspections, :aircraft_id, :integer
  end
end
