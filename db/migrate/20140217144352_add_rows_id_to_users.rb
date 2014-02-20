class AddRowsIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rows_id, :integer
  end
end
