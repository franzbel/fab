class AddColumnToComponents < ActiveRecord::Migration
  def change
    add_column :components, :beginning_time, :date
  end
end
