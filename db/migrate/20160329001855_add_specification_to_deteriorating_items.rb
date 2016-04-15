class AddSpecificationToDeterioratingItems < ActiveRecord::Migration
  def change
    add_column :deteriorating_items, :specification, :text
  end
end
