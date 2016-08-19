class CreateProductButtons < ActiveRecord::Migration[5.0]
  def change
    create_table :product_buttons do |t|
      t.string :button_type
      t.string :title
      t.string :url
      t.string :payload
      t.integer :product_id

      t.timestamps
    end
  end
end
