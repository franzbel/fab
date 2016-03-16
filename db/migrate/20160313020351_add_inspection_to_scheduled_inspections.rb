class AddInspectionToScheduledInspections < ActiveRecord::Migration
  def change
    add_column :scheduled_inspections, :inspection, :string
  end
end
