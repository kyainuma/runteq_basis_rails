class RenameFirstNamaColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :first_nama, :first_name
  end
end
