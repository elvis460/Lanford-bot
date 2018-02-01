require "#{Rails.root}/app/helpers/bots_helper"
include BotsHelper

namespace :events do
  task coin_info_broadcast: :environment do
    # get rise highest coin today
    data = JSON.parse(RestClient.get "https://api.coinmarketcap.com/v1/ticker/?limit=1600")
    top_index = data.map{|x| x['percent_change_24h'].to_i}.each_with_index.max.last
    top_coin_today = data[top_index]
    # increase the grow_most_one_day value of the coin
    coin = DigitCoin.find_by_name(top_coin_today['name']).increment('grow_most_one_day')
    coin.save
    message=
    "Rise Highest Coin Today:   [24H Change Percent:] #{coin['percent_change_24h']}%, Name: #{coin['name']},  Symbol: #{coin['symbol']},  USD price: #{coin['price_usd']},  BTC price: #{coin['price_btc']}. "
    # update user's fb_id
    get_user_data
    # send today's info to theire messenger
    User.all.each do |user|
      send_text_message(user.fb_id, message)
    end
  end
end

