class AddAskedTimesToDigitCoins < ActiveRecord::Migration[5.0]
  def change
    add_column :digit_coins, :asked_times, :integer, :default => 0
    add_column :digit_coins, :grow_most_one_day, :integer, :default => 0
    add_column :digit_coins, :top_two_times, :integer, :default => 0    
  end
end
