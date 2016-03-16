class AddColumnToIntermediateInspections < ActiveRecord::Migration
  def change
    add_column :intermediate_inspections, :aircraft_id, :integer
  end
end
