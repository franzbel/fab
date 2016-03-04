class FlightSheetsController < ApplicationController
  def index
    @flight_sheets = FlightSheet.all
  end

  def new
    @flight_sheet = FlightSheet.new
  end

  def create
    # render(:text => params)
    @flight_sheet = FlightSheet.new(flight_sheet_params)
    @aircraft = Aircraft.find(params[:flight_sheet][:aircraft_id])
    @flight_sheet.aircraft = @aircraft
    @flight_sheet.save
    redirect_to @flight_sheet
  end

  def show
    # render(:text => params)
    @flight_sheet = FlightSheet.find(params[:id])
  end

  def edit
    # render(:text => params)
    @flight_sheet = FlightSheet.find(params[:id])
  end

  def update
    @flight_sheet = FlightSheet.find(params[:id])
    @flight_sheet.update(flight_sheet_params)
    redirect_to @flight_sheet
  end

  private
  def flight_sheet_params
    params.require(:flight_sheet).permit(:aircraft_id, :departure_time, :arrival_time)
  end
end
