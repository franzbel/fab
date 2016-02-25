class ComponentsController < ApplicationController
  def new
  end

  def create
    @system = System.find(params[:system_id])
    @component = Component.new(component_params)
    @component.system = @system
    respond_to do |format|
      if @component.save
        format.js {}
      end
    end
  end

  def get_inspections_list
    @component = Component.find(params[:id])
    @inspections = @component.inspections
    respond_to do |format|
      format.js{}
    end
  end

  def get_inspections
    @component = Component.find(params[:id])
    @inspections = @component.inspections
    respond_to do |format|
      format.js{}
    end
  end

  private
  def component_params
    params.require(:component).permit(:name)
  end
end

