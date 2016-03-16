class AddColumnsToIntermediateInspections < ActiveRecord::Migration
  def change
    add_column :intermediate_inspections, :alert_before, :integer
    add_column :intermediate_inspections, :unit_ab, :string
  end
end
