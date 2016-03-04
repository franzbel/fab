class Component < ActiveRecord::Base
  has_many :inspections
  belongs_to :system
  has_many :intermediate_inspections
  has_many :first_inspections
end
