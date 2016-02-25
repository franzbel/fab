class InspectionsController < ApplicationController
  def new

  end

  def create
    # render(:text => params)
    @component = Component.find(params[:component_id])
    @inspection = Inspection.new(inspection_params)
    @inspection.component = @component
    respond_to do |format|
      if @inspection.save
        format.js {}
      end
    end
  end

  def get_tools_list
    @inspection = Inspection.find(params[:id])
    @tools = @inspection.special_tools
    respond_to do |format|
      format.js{}
    end
  end

  private
  def inspection_params
    params.require(:inspection).permit(:name)
  end
end
