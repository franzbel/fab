class SecondInspectionsController < ApplicationController
  def new
    # render(:text => 'ok')
  end

  def create
    # render(:text => params)
    @second_inspection = SecondInspection.new(second_inspection_params)
    if @second_inspection.save
      render(:text => 'inspection 100Fh ok')
    end
  end


  private

  def second_inspection_params
    params.permit(:component_id, :inspection_id, :time_limit, :unit_tl, :surplus, :unit_sp, :last_inspection, :alert_before, :unit_ab, :aircraft_id)
  end

end
