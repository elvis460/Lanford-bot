class CreateDigitCoins < ActiveRecord::Migration[5.0]
  def change
    create_table :digit_coins do |t|
      t.string :name
      t.string :symbol
      t.string :percent_change_24h
      t.string :price_usd
      t.string :price_btc

      t.timestamps
    end
  end
end
