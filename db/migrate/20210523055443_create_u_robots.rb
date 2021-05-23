class CreateURobots < ActiveRecord::Migration[6.0]
  def change
    create_table :u_robots do |t|
      t.string :name

      t.timestamps
    end
  end
end
