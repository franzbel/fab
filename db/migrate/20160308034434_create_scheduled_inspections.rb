class CreateScheduledInspections < ActiveRecord::Migration
  def change
    create_table :scheduled_inspections do |t|
      t.references :component, index: true, foreign_key: true
      t.integer :flight_hours
      t.integer :start_at
      t.integer :inspection_at
      t.integer :finish_at
      t.boolean :done, :default => false

      t.timestamps null: false
    end
  end
end
