class CreateFirstInspections < ActiveRecord::Migration
  def change
    create_table :first_inspections do |t|
      t.integer :time_limit
      t.string :unit_tl
      t.integer :surplus
      t.string :unit_sp
      t.string :last_inspection
      t.references :component, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
