class FlightSheet < ActiveRecord::Base
  belongs_to :aircraft
  before_save :set_flight_time
  after_save :set_flight_hours_aircraft, :set_flight_hours_component

  private
  def set_flight_time
    self.flight_time = (self.arrival_time - self.departure_time) / 1.hour
  end

  def set_flight_hours_aircraft
    aircraft = Aircraft.find(self.aircraft_id)
    aircraft.flight_hours = aircraft.flight_hours + flight_time
    aircraft.save
  end

  def set_flight_hours_component
    Aircraft.find(self.aircraft_id).systems.each do |system|
      system.components.each do |component|
        component.flight_hours = component.flight_hours + self.flight_time
        component.save
      end
    end
  end
end
