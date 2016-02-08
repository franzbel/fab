class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.string :name
      t.references :component, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
