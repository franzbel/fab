class TwelveMonthsInspectionsController < ApplicationController
  def new
    # render(:text => 'ok')
  end
  def create
    # render(:text => params)
    @twelve_months_inspection = TwelveMonthsInspection.new(inspection_params)
    if @twelve_months_inspection.save
      render(:text => 'ok')
    end
  end
  private
  def inspection_params
    params.permit(:component_id, :inspection_id, :time_limit, :unit_tl, :surplus, :unit_sp, :last_inspection, :alert_before, :unit_ab, :aircraft_id)
  end
end
