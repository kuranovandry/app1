class AddFirstNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_namer, :string
  end
end
