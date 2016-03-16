class ScheduledInspection < ActiveRecord::Base
  belongs_to :component

  after_initialize :filter

  before_save :set_flight_hours

  def set_flight_hours
    self.flight_hours = (Component.find(self.component_id).flight_hours*60).to_i
  end

  def filter
    if new_record?
      if intermediate_inspection?
        self.calculate_intermediate
      end
      if supplementary_check_100?
        self.calculate_sc_100
      end
      if supplementary_check_50?
        self.calculate_sc_50
      end
    end
  end

# OJO: Estamos suponiendo una sola inspección ( inspection = component.intermediate_inspections.first)
  def intermediate_inspection?
    component = Component.find(self.component_id)
    unless component.intermediate_inspections.empty?
      flight_hours = component.flight_hours
      inspection = component.intermediate_inspections.first
      time_limit = inspection.time_limit
      alert_before = inspection.alert_before
      surplus = inspection.surplus
      if flight_hours % time_limit >= time_limit - alert_before || flight_hours % time_limit <= surplus
        return true
      end
    end
    false
  end

  def calculate_intermediate

  end

  # OJO: Estamos suponiendo una sola inspección
  def supplementary_check_100?
    component = Component.find(self.component_id)
    unless component.second_inspections.empty?
      flight_hours = component.flight_hours
      inspection = component.second_inspections.first
      time_limit = inspection.time_limit
      alert_before = inspection.alert_before
      surplus = inspection.surplus
      if flight_hours % time_limit >= time_limit - alert_before || flight_hours % time_limit <= surplus
        return true
      end
    end
    false
  end
  def calculate_sc_100
    component = Component.find(self.component_id)
    flight_hours = (component.flight_hours*60).to_i
    inspection = component.second_inspections.first
    time_limit = inspection.time_limit*60
    alert_before = inspection.alert_before*60
    surplus = inspection.surplus*60
    from_index = (flight_hours - (surplus + alert_before)).to_i
    to_index = (flight_hours + (surplus + alert_before)).to_i
    # new record
    if self.new_row_sc_100?
      (from_index..to_index).each { |value|
        if value % time_limit == 0
          self.inspection_at= value
          self.start_at= value - alert_before
          self.finish_at= value + surplus
          self.inspection = 'sc_100'
          self.save
          return
        end
      }
    else
      ScheduledInspection.where('component_id==?',self.component_id).last.update(flight_hours: 0)
    end
  end
  def new_row_sc_100?
    # si el componente existe
    unless Component.where('id==?', self.component_id).empty?
      # si el componente tiene una inspección de 50 asociada
      unless Component.find(self.component_id).second_inspections.first.nil?
        # si existe una inspección calculada para el componente (una fila en scheduled_inspections)
        unless ScheduledInspection.find_by_component_id(self.component_id).nil?
          if (Component.find(self.component_id).flight_hours*60).to_i > ScheduledInspection.where('component_id==?',self.component_id).last.finish_at
            return true
          else
            return false
          end
        end
        # la inspección es nueva y se necesita una nueva fila
        return true
      end

    end
    false
  end
  # OJO: Estamos suponiendo una sola inspección
  def supplementary_check_50?
    component = Component.find(self.component_id)
    unless component.first_inspections.empty?
      flight_hours = component.flight_hours
      inspection = component.first_inspections.first
      time_limit = inspection.time_limit
      alert_before = inspection.alert_before
      surplus = inspection.surplus
      if flight_hours % time_limit >= time_limit - alert_before || flight_hours % time_limit <= surplus
        return true
      end
    end
    false
  end

  def calculate_sc_50
    component = Component.find(self.component_id)
    flight_hours = (component.flight_hours*60).to_i
    inspection = component.first_inspections.first
    time_limit = inspection.time_limit*60
    alert_before = inspection.alert_before*60
    surplus = inspection.surplus*60
    from_index = (flight_hours - (surplus + alert_before)).to_i
    to_index = (flight_hours + (surplus + alert_before)).to_i
    # new record
    if self.new_row_sc_50?
      (from_index..to_index).each { |value|
        if value % time_limit == 0
          self.inspection_at= value
          self.start_at= value - alert_before
          self.finish_at= value + surplus
          self.inspection = 'sc_50'
          self.save
          return
        end
      }
    else
       ScheduledInspection.where('component_id==?',self.component_id).last.update(flight_hours: 0)
    end
  end

  # devuelve falso cuando no es necesaria una nueva fila
  # devuelve verdadero cuando es necesaria una nueva fila
  def new_row_sc_50?
    # si el componente existe
    unless Component.where('id==?', self.component_id).empty?
      # si el componente tiene una inspección de 50 asociada
      unless Component.find(self.component_id).first_inspections.first.nil?
        # si existe una inspección calculada para el componente (una fila en scheduled_inspections)
        unless ScheduledInspection.find_by_component_id(self.component_id).nil?
          if (Component.find(self.component_id).flight_hours*60).to_i > ScheduledInspection.where('component_id==?',self.component_id).last.finish_at
            return true
          else
            return false
          end
        end
        # la inspección es nueva y se necesita una nueva fila
        return true
      end
    end
    false
  end


  # def first_time_sc_50?
  #   unless Component.find(self.component_id).first_inspections.first.nil?
  #     return true
  #   end
  #   false
  # end
  #
  # Ultimo registro del mismo tipo
  # def last_register
  #   ScheduledInspection.where('id<? AND component_id==?', self.id, self.component_id).last
  # end

  # def new_row?
  #   last_r = ScheduledInspection.where('id<? AND component_id==?', self.id, self.component_id).last
  #   if last_r.start_at <= self.flight_hours && last_r.finish_at >= self.flight_hours
  #     return true
  #   end
  #   false
  # end

  # def new_row?(v_flight_hours, v_component_id)
  #   unless ScheduledInspection.where('start_at <= ? AND finish_at >= ? AND component_id == ?',  v_flight_hours, v_flight_hours, v_component_id).empty?
  #     return true
  #   end
  #   false
  # end












  # private
  # def self.previous_record(v_id)
  #   ScheduledInspection.where('id < ?', v_id).last
  # end



  # def self.range_first_inspection(v_component_id)
  #   my_array = []
  #   res = []
  #   ScheduledInspection.all.reverse_each do |record|
  #     if record.supplementary_check_50
  #       var = record
  #       while var.supplementary_check_50
  #         my_array.push(var)
  #         var = ScheduledInspection.previous_record(var.id)
  #       end
  #       my_array.each do |element|
  #         if element.component_id == v_component_id
  #           res.push(element)
  #         end
  #       end
  #       return res
  #     end
  #   end
  #   my_array
  # end
  # Retornamos la hora exacta en la que debería realizarse la inspección.
  # tenemos un problema: cuando el excedente permitido es cero

  # def self.last_first_inspection(v_component_id)
  #   my_array = ScheduledInspection.range_first_inspection(v_component_id)
  #   unless my_array.empty?
  #   first_index = my_array.last.flight_hours.to_i
  #     last_index = my_array.first.flight_hours.to_i
  #     (first_index .. last_index).each { |i|
  #       if i % 5 == 0
  #         return i
  #       end
  #     }
  #   end
  #   false
  # end

  # def self.last_first_inspection
  #   my_array = ScheduledInspection.range_first_inspection
  #
  #   my_array.each do |inspection|
  #     if Component.find(id: inspection.component_id).flight_hours % 50 == 0
  #       return
  #     end
  #   end
  # end



  # ------------------------------------------------------------------------------------------------------------------ #
  # def periodical_inspection?
  #   component = Component.find(self.component_id)
  #   inspections = component.periodical_inspections
    #
    # if ScheduledInspection.is_there_intermediate?(component.id)
    #   if component.flight_hours % 40 >= (component.periodical_inspections.last.time_limit - component.periodical_inspections.last.alert_before)
    #     return true
    #   end
    # end
    # if ScheduledInspection.is_there_periodical?(component.id)
    #   if component.flight_hours % 80 >= (component.periodical_inspections.first.time_limit - component.periodical_inspections.last.alert_before)
    #     return true
    #   end
    # end
    # false
  # end

  # Se realizo anteriormente una inspección intermedia en un determinado componente
  # def self.is_there_intermediate?(v_component_id)
  #   unless ScheduledInspection.where('component_id=? AND intermediate_inspection=?', v_component_id, true).empty?
  #     return true
  #   end
  #   false
  # end

  # Cuando fue la ultima inspección intermedia de un determinado componente
  # def self.last_intermediate_inspection(v_component_id)
  #   last_inspection = ScheduledInspection.where('component_id = ? AND intermediate_inspection = ?', v_component_id, true).last
  #   unless last_inspection.nil?
  #     last_inspection.component.flight_hours
  #   end
  # end




  # ------------------------------------------------------------------------------------------------------------------ #

  # ------------------------------------------------------------------------------------------------------------------ #
  # def supplementary_check_100?
  #   component = Component.find(self.component_id)
  #   inspections = component.second_inspections
  #   inspections.each do |inspection|
  #     if (component.flight_hours % inspection.time_limit >= inspection.time_limit - inspection.alert_before) && (component.flight_hours % inspection.time_limit <= inspection.time_limit + inspection.surplus)
  #       return true
  #     end
  #   end
  #   false
  # end
  # ------------------------------------------------------------------------------------------------------------------ #
  # def supplementary_check_50?
  #   component = Component.find(self.component_id)
  #   inspections = component.first_inspections
  #   inspections.each do |inspection|
  #     if (component.flight_hours % inspection.time_limit >= inspection.time_limit - inspection.alert_before) && (component.flight_hours % inspection.time_limit <= inspection.time_limit + inspection.surplus)
  #       return true
  #     end
  #     if component.flight_hours % inspection.time_limit == 0
  #       return true
  #     end
  #   end
  #   false
  # end
  # ------------------------------------------------------------------------------------------------------------------ #

  # Se debe realizar una inspección periódica ?
  # def intermediate_inspection?
  #   component = Component.find(self.component_id)
  #   inspection = component.intermediate_inspections.first
  #
  #   if component.flight_hours >= inspection.time_limit - inspection.alert_before && component.flight_hours < inspection.time_limit
  #     return true
  #   end
  #   if ScheduledInspection.is_there_periodical?(component.id)
  #     last_periodical_inspection = ScheduledInspection.last_periodical_inspection(component.id)
  #     if component.flight_hours - last_periodical_inspection < inspection.time_limit
  #       return true
  #     end
  #   end
  #   false
  # end

  # Se realizo anteriormente una inspección periódica en un determinado componente ?
  # def self.is_there_periodical?(v_component_id)
  #   unless ScheduledInspection.where('component_id=? AND periodical_inspection=?', v_component_id, true).empty?
  #     return true
  #   end
  #   false
  # end

  # Cuando fue la ultima inspección periódica de un determinado componente ?
  # def self.last_periodical_inspection(v_component_id)
  #   last_inspection = ScheduledInspection.where('component_id = ? AND periodical_inspection = ?', v_component_id, true).last
  #   unless last_inspection.nil?
  #     last_inspection.component.flight_hours
  #   end
  # end


  # def supplementary_check_50?
  #   component = Component.find(self.component_id)
  #   inspections = component.first_inspections
  #   inspections.each do |inspection|
  #     if component.flight_hours % inspection.time_limit >= inspection.time_limit - inspection.alert_before
  #       return true
  #     end
  #     if component.flight_hours >= inspection.time_limit
  #       if component.flight_hours % inspection.time_limit <= inspection.surplus
  #         return true
  #       end
  #     end
  #   end
  #   false
  # end
  # def supplementary_check_100?
  #   component = Component.find(self.component_id)
  #   inspections = component.second_inspections
  #   inspections.each do |inspection|
  #     if component.flight_hours % inspection.time_limit >= inspection.time_limit - inspection.alert_before
  #       return true
  #     end
  #     if component.flight_hours >= inspection.time_limit
  #       if component.flight_hours % inspection.time_limit <= inspection.surplus
  #         return true
  #       end
  #     end
  #   end
  #   false
  # end
  # supplementary check 50 Fh.
  # ------------------------------------------------------------------------------------------------------------------ #
  def inspection_name
    if self.inspection == 'sc_50'
      return 'Supplementary check 50 Fh'
    end
    if self.inspection == 'sc_100'
      return 'Supplementary check 100 Fh'
    end
    if self.inspection == 'intermediate'
      return 'Intermediate inspection'
    end
    ''
  end

  def aircraft_name
    Component.find(self.component_id).system.aircraft.plate_number
  end

  def system_name
    Component.find(self.component_id).system.name
  end

  def component_name
    Component.find(self.component_id).name
  end
end
