class CreateDeterioratingItems < ActiveRecord::Migration
  def change
    create_table :deteriorating_items do |t|
      t.string :name
      t.string :unit
      t.timestamps null: false
    end
  end
end
