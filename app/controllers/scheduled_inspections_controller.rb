class ScheduledInspectionsController < ApplicationController
  def index
    @scheduled_inspections = ScheduledInspection.all
  end
end
