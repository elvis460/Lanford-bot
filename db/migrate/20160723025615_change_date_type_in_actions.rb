class ChangeDateTypeInActions < ActiveRecord::Migration[5.0]
  def up
    change_column :actions, :action_type, :integer
  end

  def down
    change_column :actions, :action_type, :string
  end
end
