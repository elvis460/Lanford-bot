require "#{Rails.root}/app/helpers/bots_helper"
include BotsHelper

namespace :events do
  task coin_info_broadcast: :environment do
    data = JSON.parse(RestClient.get "https://api.coinmarketcap.com/v1/ticker/?limit=1600")
    top_index = data.map{|x| x['percent_change_24h'].to_i}.each_with_index.max.last
    top_coin_today = data[top_index]
    message=
    "Rise Highest Coin Today:
      [24H Change Percent:] #{top_coin_today['percent_change_24h']}%,
      Name: #{top_coin_today['name']},
      Symbol: #{top_coin_today['symbol']},
      USD price: #{top_coin_today['price_usd']},
      BTC price: #{top_coin_today['price_btc']}.
    "
    User.all.each do |user|
      send_text_message(user.fb_id, message)
    end
  end
end

