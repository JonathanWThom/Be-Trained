class CreateWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :workouts do |t|
      t.datetime :date
      t.text :workout
      t.text :coach_notes
      t.text :results
      t.text :athlete_notes
      t.integer :athlete_id
    end
  end
end
