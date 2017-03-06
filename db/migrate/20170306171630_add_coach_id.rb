class AddCoachId < ActiveRecord::Migration[5.0]
  def change
    add_column :athletes, :coach_id, :integer
  end
end
