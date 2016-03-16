class AddColumnToFirstInspections < ActiveRecord::Migration
  def change
    add_column :first_inspections, :aircraft_id, :integer
  end
end
