class AddApiToJson < ActiveRecord::Migration[5.0]
  def change
    add_reference :jsons, :api, foreign_key: true
  end
end
