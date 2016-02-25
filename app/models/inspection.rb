class Inspection < ActiveRecord::Base
  has_many :special_tools
  belongs_to :component
end
