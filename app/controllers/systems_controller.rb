class SystemsController < ApplicationController

  def new
    @system = System.new
  end

  def create
    @aircraft = Aircraft.find(params[:aircraft_id])
    @system = System.new(system_params)
    @system.aircraft = @aircraft
    respond_to do |format|
      if @system.save
        format.js {}
      end
    end
  end

  def get_components_list
    # render(:text => params)
    @system = System.find(params[:id])
    @components = @system.components
    respond_to do |format|
      format.js{}
    end
  end

  def get_components
    @system = System.find(params[:id])
    @components = @system.components
    respond_to do |format|
      format.js{}
    end
  end

  private
  def system_params
    params.require(:system).permit(:name)
  end
end
