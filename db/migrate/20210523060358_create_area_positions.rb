class CreateAreaPositions < ActiveRecord::Migration[6.0]
  def change
    create_table :area_positions do |t|
      t.integer :x
      t.integer :y
      t.integer :face
      t.boolean :initial

      t.references :u_robot
      t.references :area

      t.timestamps
    end
  end
end
