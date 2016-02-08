class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.references :aircraft, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
