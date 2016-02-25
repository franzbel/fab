module InspectionsHelper
  def options_for_components
    s = ''
    Component.all.each do |component|
      s << "<option value='#{component.id}'>#{component.name}</option>"
    end
    s.html_safe
  end
end

