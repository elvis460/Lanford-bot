class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :string
    add_column :users, :locale, :string
  end
end
