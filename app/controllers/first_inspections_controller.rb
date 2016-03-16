class FirstInspectionsController < ApplicationController
  def new
  end

  def create
    # render(:text => params)
    @first_inspection = FirstInspection.new(first_inspection_params)
    if @first_inspection.save
      render(:text => 'ok')
    end
  end
  private
  def first_inspection_params
    params.permit(:component_id, :inspection_id, :time_limit, :unit_tl, :surplus, :unit_sp, :last_inspection, :alert_before, :unit_ab, :aircraft_id)
  end
end
