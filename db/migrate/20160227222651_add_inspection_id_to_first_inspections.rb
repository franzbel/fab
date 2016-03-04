class AddInspectionIdToFirstInspections < ActiveRecord::Migration
  def change
    add_column :first_inspections, :inspection_id, :integer
  end
end
