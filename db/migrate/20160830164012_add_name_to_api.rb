class AddNameToApi < ActiveRecord::Migration[5.0]
  def change
    add_column :apis, :name, :string
  end
end
