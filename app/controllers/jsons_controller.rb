class JsonsController < ApplicationController

  def new
    @api = Api.find(params[:api_id])
    @json = Json.new
  end

  def create
    @api = Api.find(params[:api_id])
    @json = @api.jsons.create(json_params)
    redirect_to api_path(@api)
  end

  private

  def json_params
    params.require(:json).permit(:name, :content)
  end

end
