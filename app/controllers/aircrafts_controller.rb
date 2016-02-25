class AircraftsController < ApplicationController
  def new
    @aircraft = Aircraft.new
    @aircrafts = Aircraft.all
  end

  def create
    @aircraft = Aircraft.new(aircraft_params)
    respond_to do |format|
      if @aircraft.save
        format.js {}
      end
    end
  end

  def get_systems
    @aircraft = Aircraft.find(params[:id])
    @systems = @aircraft.systems
    respond_to do |format|
      format.js{}
    end
  end

  def get_systems_list
    @aircraft = Aircraft.find(params[:id])
    @systems = @aircraft.systems
    respond_to do |format|
      format.js{}
    end
  end

  private
  def aircraft_params
    params.require(:aircraft).permit(:plate_number)
  end
end
