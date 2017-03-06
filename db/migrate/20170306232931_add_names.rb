class AddNames < ActiveRecord::Migration[5.0]
  def change
    add_column :athletes, :first_name, :string
    add_column :athletes, :last_name, :string
    add_column :coaches, :first_name, :string
    add_column :coaches, :last_name, :string
  end
end
