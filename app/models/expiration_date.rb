class ExpirationDate < ActiveRecord::Base
  belongs_to :quantity

  def days_before_expiry
    (self.date - Date.today).to_i
  end

  def days_from_alert
    (self.date - DeterioratingItem.find(self.deteriorating_item_id).date_before_alert.to_date).to_i
  end
end
