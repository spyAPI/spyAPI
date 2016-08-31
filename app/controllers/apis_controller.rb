require 'securerandom'

class ApisController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :find_by_params, except: [:index, :new, :create]
  before_action :api_owner, only: [:update, :destroy, :edit]


  def index
    unless params['api-key']
      render json: JSON.parse('{"message":"No API Key found in headers, body or querystring"}')
    else
      api = Api.where(key: params['api-key'])
      render json: api[0].jsons.select {|x| x.name == params['json']}
    end
  end

  def new
    @api = Api.new
  end

  def create
    key = SecureRandom.hex(20)
    @api = Api.create(api_params)
    @api.key = key
    @api.user_id = current_user.id
    @api.save
    redirect_to '/'
  end

  def show

  end

  def edit

  end

  def update
    @api.name = params[:api][:name]
    if params[:key][:api] == "1"
      @api.key = SecureRandom.hex(20)
    end
    @api.save
    redirect_to '/'
  end

  def destroy
    @api.destroy
    flash[:notice] = "API successfully deleted"
    redirect_to '/'
  end

  private

  def api_params
    params.require(:api).permit(:name)
  end

  def find_by_params
    @api = Api.find(params[:id])
  end

  def api_owner
    unless @api.user_id == current_user.id
      flash[:notice] = "Permission denied: only owner has edit/delete privileges"
      redirect_to '/'
    end
  end

end
