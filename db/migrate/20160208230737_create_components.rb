class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.references :system, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
