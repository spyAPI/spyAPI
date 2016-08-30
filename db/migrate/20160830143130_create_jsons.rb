class CreateJsons < ActiveRecord::Migration[5.0]
  def change
    create_table :jsons do |t|
      t.string :name
      t.json :content

      t.timestamps
    end
  end
end
