class DeterioratingItem < ActiveRecord::Base
  has_many :quantities
  has_one :alert
  accepts_nested_attributes_for :quantities

#   Cantidad total del producto
  def total_quantity
    total = 0.0
    self.quantities.each do |quantity|
      total = total + quantity.number
    end
    total
  end

  def replenish?
    if self.total_quantity <= self.alert.minimum_quantity
      return true
    end
    false
  end

  def date_before_alert
      Time.now - self.alert.best_before.days
  end

  def days_from_alert
    (Time.now - self.date_before_alert) / 86400
  end
end
