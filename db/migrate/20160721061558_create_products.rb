class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :subtitle
      t.string :item_url
      t.string :image_url
      t.integer :action_id

      t.timestamps
    end
  end
end
