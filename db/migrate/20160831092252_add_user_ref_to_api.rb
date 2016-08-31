class AddUserRefToApi < ActiveRecord::Migration[5.0]
  def change
    add_reference :apis, :user, foreign_key: true
  end
end
