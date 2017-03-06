class AddConfirmedAthletes < ActiveRecord::Migration[5.0]
  def change
    add_column :athletes, :confirmed, :boolean, :default => false
  end
end
