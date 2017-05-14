class AddTimestampsToExercises < ActiveRecord::Migration[5.0]
  def change
    add_timestamps(:exercises, null: true)
  end
end
