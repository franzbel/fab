class AddColumnToPeriodicalInspections < ActiveRecord::Migration
  def change
    add_column :periodical_inspections, :aircraft_id, :integer
  end
end
