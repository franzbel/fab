class CreateSecondInspections < ActiveRecord::Migration
  def change
    create_table :second_inspections do |t|
      t.integer :time_limit
      t.string :unit_tl
      t.integer :surplus
      t.string :unit_sp
      t.string :last_inspection
      t.integer :inspection_id
      t.references :component, index: true, foreign_key: true
      t.integer :alert_before
      t.string :unit_ab

      t.timestamps null: false
    end
  end
end
