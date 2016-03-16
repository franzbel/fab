class AddColumnsToFirstInspections < ActiveRecord::Migration
  def change
    add_column :first_inspections, :alert_before, :integer
    add_column :first_inspections, :unit_ab, :string
  end
end
