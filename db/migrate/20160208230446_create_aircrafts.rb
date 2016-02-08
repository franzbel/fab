class CreateAircrafts < ActiveRecord::Migration
  def change
    create_table :aircrafts do |t|
      t.string :plate_number

      t.timestamps null: false
    end
  end
end
