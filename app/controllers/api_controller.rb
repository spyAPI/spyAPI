class ApiController < ApplicationController
  def index
    unless params['api-key']
      render json: JSON.parse('{"message":"No API Key found in headers, body or querystring"}')
    else
      api = Api.where(key: params['api-key'])
      p api
      # binding.pry
      render json: api[0].jsons[0]
    end
  end
end
