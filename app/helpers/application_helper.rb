module ApplicationHelper
  def options_for_aircrafts
    s = ''
    Aircraft.all.each do |aircraft|
      s << "<option value='#{aircraft.id}'>#{aircraft.plate_number}</option>"
    end
    s.html_safe
  end
end
