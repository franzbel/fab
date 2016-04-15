class CreateExpirationDates < ActiveRecord::Migration
  def change
    create_table :expiration_dates do |t|
      t.date :date
      t.references :quantity, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
