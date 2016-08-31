class Api < ApplicationRecord
  has_many :jsons
  belongs_to :user
end
