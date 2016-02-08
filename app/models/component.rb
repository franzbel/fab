class Component < ActiveRecord::Base
  has_many :inspections
  belongs_to :system
end
