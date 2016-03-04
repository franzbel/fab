class CreateIntermediateInspections < ActiveRecord::Migration
  def change
    create_table :intermediate_inspections do |t|
      t.references :component, index: true, foreign_key: true
      t.integer :inspection_id
      t.integer :time_limit
      t.string :unit_tl
      t.integer :surplus
      t.string :unit_sp
      t.string :last_inspection

      t.timestamps null: false
    end
  end
end
