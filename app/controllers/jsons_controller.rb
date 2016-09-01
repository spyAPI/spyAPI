class JsonsController < ApplicationController

  before_action :find_api_by_params, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :json_owner, except: [:new, :create]

  def new
    @json = Json.new
  end

  def create
    @json = @api.jsons.new(json_params)

    if @json[:content].is_json?
      # if unique_title?
        @json.save
        redirect_to api_path(@api)
      # else
      #   flash.now[:alert] = "Name has already been used"
      #   render :new
      # end
    else
      flash.now[:alert] = 'Content is not a valid JSON'
      render :new
    end
  end

  def show
    @json = @api.jsons.find(params[:id])
  end

  def edit
    @json = @api.jsons.find(params[:id])
  end

  def update
    @json = @api.jsons.find(params[:id])
    @json.update(json_params)
    redirect_to api_path(@api)
  end

  def destroy
    @json = @api.jsons.find(params[:id])
    @json.destroy
    flash[:notice] = "JSON successfully deleted"
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

  def unique_title?
    @api.jsons.where(:name == @json.name).count == 0
  end

end
