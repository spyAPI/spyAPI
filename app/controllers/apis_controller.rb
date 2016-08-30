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
    #TODO generate API key using secure random module
    key = SecureRandom(20)
    Api.create(name: api_params('name'), key: key)
  end

  private

  def api_params
    
  end
end
