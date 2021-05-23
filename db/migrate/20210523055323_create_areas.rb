class CreateAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :x_min
      t.integer :x_max
      t.integer :y_min
      t.integer :y_max

      t.timestamps
    end
  end
end
