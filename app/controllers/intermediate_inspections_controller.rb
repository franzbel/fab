class IntermediateInspectionsController < ApplicationController
  def new

  end

  def create
    # render(:text => params)
    @intermediate_inspection =  IntermediateInspection.new(intermediate_inspection_params)
    if @intermediate_inspection.save
      render(:text => 'ok')
    end
  end
  private
  def intermediate_inspection_params
    params.permit(:component_id, :inspection_id, :time_limit, :unit_tl, :surplus, :unit_sp, :last_inspection)
  end
end
