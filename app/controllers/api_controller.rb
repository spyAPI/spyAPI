class ApiController < ApplicationController
  def index
    unless params['api-key']
      render json: JSON.parse('{"message":"No API Key found in headers, body or querystring"}')
    else
      api = Api.where(key: params['api-key'])
      render json: api[0].jsons.select {|x| x.name == params['json']}
    end
  end
end
