class Component < ActiveRecord::Base
  has_many :inspections
  belongs_to :system
  has_many :intermediate_inspections
  has_many :first_inspections
  has_many :second_inspections
  has_many :twelve_months_inspections
  has_many :periodical_inspections
  has_many :scheduled_inspections
  after_update :update_scheduled_inspections


  private
  def update_scheduled_inspections
    ScheduledInspection.new(:component_id=>self.id)
  end

end
