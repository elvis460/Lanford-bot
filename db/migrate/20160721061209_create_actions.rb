class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.string :name
      t.string :action_type

      t.timestamps
    end
  end
end
