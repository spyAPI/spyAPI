class Api < ApplicationRecord
  has_many :jsons, dependent: :destroy
  belongs_to :user
end
