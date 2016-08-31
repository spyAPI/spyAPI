require 'securerandom'

class Api < ApplicationRecord
  has_many :jsons, dependent: :destroy
  belongs_to :user

  def self.generate_key
    return SecureRandom.hex(20)
  end

  def self.generate_JSON(params)
    unless params['api-key']
      return JSON.parse('{"message":"No API Key found in headers, body or querystring"}')
    else
      api = Api.where(key: params['api-key'])
      return api[0].jsons.select {|x| x.name == params['json']}
    end
  end

end
