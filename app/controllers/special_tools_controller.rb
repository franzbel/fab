class SpecialToolsController < ApplicationController
  def new
    @tools = []
    5.times do
      @tools << SpecialTool.new
    end
  end

  def create
    # render(:text => params)
    @inspection = Inspection.find(params[:inspection_id])
    @tools = []
    params[:tools].each do |tool|
      if tool['name'] != ''
        new_tool = SpecialTool.new(special_tool_params(tool))
        new_tool.inspection = @inspection
        new_tool.save
        @tools << tool
      end
    end
    respond_to do |format|
      format.js{}
    end
  end
  private
  def special_tool_params(my_params)
    my_params.permit(:name)
  end
end
