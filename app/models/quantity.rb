class Quantity < ActiveRecord::Base
  belongs_to :deteriorating_item
  has_one :expiration_date
  accepts_nested_attributes_for :expiration_date
end
