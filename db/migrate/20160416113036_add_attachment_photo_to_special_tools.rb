class AddAttachmentPhotoToSpecialTools < ActiveRecord::Migration
  def self.up
    change_table :special_tools do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :special_tools, :photo
  end
end
