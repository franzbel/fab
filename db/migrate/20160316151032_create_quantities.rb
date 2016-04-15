class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.float :number
      t.references :deteriorating_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
