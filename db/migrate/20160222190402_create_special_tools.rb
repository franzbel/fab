class CreateSpecialTools < ActiveRecord::Migration
  def change
    create_table :special_tools do |t|
      t.string :name
      t.references :inspection, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
