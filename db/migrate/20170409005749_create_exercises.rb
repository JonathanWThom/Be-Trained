class CreateExercises < ActiveRecord::Migration[5.0]
  def change
    create_table :exercises do |t|
      t.string  "name"
      t.integer "record"
      t.string  "unit"
      t.date    "date"
      t.integer "athlete_id"
    end
  end
end
