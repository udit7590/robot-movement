class CreateMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :movements do |t|
      t.integer :step

      t.references :u_robot
      t.references :area

      t.timestamps
    end
  end
end
