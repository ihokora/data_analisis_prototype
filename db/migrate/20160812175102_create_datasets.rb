class CreateDatasets < ActiveRecord::Migration[5.0]
  def change
    create_table :datasets do |t|
      t.string :data_x
      t.string :data_y

      t.timestamps
    end
  end
end
