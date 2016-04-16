class Component < ActiveRecord::Base
  has_many :inspections
  belongs_to :system
  has_one :intermediate_inspection
  has_one :first_inspection
  has_one :second_inspection
  has_one :twelve_months_inspection
  has_one :periodical_inspection
  has_many :scheduled_inspections
  after_update :update_scheduled_inspections


  private
  def update_scheduled_inspections
    ScheduledInspection.new(:component_id=>self.id)
  end

end
