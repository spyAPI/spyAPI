require 'securerandom'

class ApisController < ApplicationController

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
    @api = Api.find(params[:id])
  end

  private

  def api_params
    params.require(:api).permit(:name)
  end
end
