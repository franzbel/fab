class SpecialToolsController < ApplicationController
  def new
    @tool = SpecialTool.new
    @tools = []
    5.times do
      @tools << SpecialTool.new
    end
  end

  def create
    # render(:text => params.require(:special_tool).require(:tools))
    @inspection = Inspection.find(params[:inspection_id])
    @tools = []
    params.require(:special_tool).require(:tools).each do |tool|
      if tool['name'] != ''
        new_tool = SpecialTool.new(special_tool_params(tool))
        new_tool.inspection = @inspection
        new_tool.save
        @tools << tool
      end
    end
    # respond_to do |format|
    #   format.js{}
    # end
    render :text => 'ok'
  end
  private
  def special_tool_params(my_params)
    my_params.permit(:name, :photo)
  end
end
