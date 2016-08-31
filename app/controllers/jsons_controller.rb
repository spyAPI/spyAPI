class JsonsController < ApplicationController

  before_action :find_api_by_params, only: [:new, :create, :edit, :update]
  before_action :json_owner, except: [:new, :create]

  def new
    @json = Json.new
  end

  def create
    @json = @api.jsons.create(json_params)
    redirect_to api_path(@api)
  end

  def edit
    @json = @api.jsons.find(params[:id])
  end

  def update
    @json = @api.jsons.find(params[:id])
    @json.update(json_params)
    redirect_to api_path(@api)
  end

  private

  def json_params
    params.require(:json).permit(:name, :content)
  end

  def find_api_by_params
    @api = Api.find(params[:api_id])

  end

  def json_owner
    unless @api.user_id == current_user.id
      flash[:notice] = "Permission denied: only owner has access"
      redirect_to '/'
    end
  end

end
