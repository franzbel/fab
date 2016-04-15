class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :best_before
      t.float :minimum_quantity
      t.references :deteriorating_item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
