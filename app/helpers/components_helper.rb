module ComponentsHelper
  def options_for_systems
    s = ''
    System.all.each do |system|
      s << "<option value='#{system.id}'>#{system.name}</option>"
    end
    s.html_safe
  end
end
