class CreateApis < ActiveRecord::Migration[5.0]
  def change
    create_table :apis do |t|
      t.string :key

      t.timestamps
    end
  end
end
