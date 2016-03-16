class PeriodicalInspectionsController < ApplicationController
  def new
  end
  def create
    # render(:text => params)
    @periodical_inspection = PeriodicalInspection.new(inspection_params)
    if @periodical_inspection.save
      render(:text => 'ok')
    end
  end
  private
  def inspection_params
    params.permit(:component_id, :inspection_id, :time_limit, :unit_tl, :surplus, :unit_sp, :last_inspection, :alert_before, :unit_ab, :aircraft_id)
  end
end
