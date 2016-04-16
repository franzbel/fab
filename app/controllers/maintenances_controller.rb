class MaintenancesController < ApplicationController
  def index
    @scheduled_inspections = ScheduledInspection.all
  end
  def tools

  end
  def procedure
    # render :text => params[:id]
    scheduled_inspection = ScheduledInspection.find(params[:id])
    component_id = scheduled_inspection.component_id
    inspection = Inspection.find_by_component_id(component_id)
    @tools = inspection.special_tools
  end
end
