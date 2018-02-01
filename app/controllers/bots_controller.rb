class BotsController < ApplicationController
  include BotsHelper

  skip_before_action :verify_authenticity_token
  require 'rest-client'
  require 'nokogiri'

  def index
    
  end

  def webhook
    if (params['hub.mode'] == 'subscribe' && params['hub.verify_token'] == Settings.Messenger_api.verify_token) 
      render text: params['hub.challenge']
      return
    end
  end

  def receive_message
    if params[:entry] && params[:object] == 'page'
      messaging_events = params[:entry][0][:messaging]
      messaging_events.each do |event|
        sender = event[:sender][:id]
        User.create(fb_id: sender) if !User.find_by(fb_id: sender)
        if (event[:message] && text = event[:message][:text])
          if (event[:message][:quick_reply] && payload = event[:message][:quick_reply][:payload])
            case payload
              when 'Greet'
                default_message(sender)
              when 'Skills'
                send_text_message(sender, '發摟我，每天給最Hot虛擬貨幣資訊')  
              when 'Shoes'
                sale_shoes(sender)
              # when Action.first.name
              #   do_action(sender, Action.first.name)
              when 'morning'
                good_morning(sender)
              when 'evening'
                good_afternoon(sender)  
              when 'night'
                good_night(sender) 
            end
          else
            if Action.all.map{|x| x.name}.index(text)
              do_action(sender, text)
            else
              case text
                # when Action.all.map{|x| x.name}
                  
                when 'hello'
                  send_text_message(sender, "I'm Lanford.") 
                # when '鞋子'
                #   sale_shoes(sender) 
                # when 'trace'
                #   bamboo_trace(sender) 
                # when Action.first.name
                #   do_action(sender, Action.first.name)    
                # when 'moduletest'
                #   do_action(sender, Action.first.name)  
                else
                  # search the coin name or symbol legal or not
                  digitcoin = DigitCoin.where("name =? OR symbol =?", text, text)
                  if digitcoin.present?
                    coin = digitcoin.first
                    coin.increment('asked_times')
                    # save the increment of asked_times
                    coin.save
                    # get coin info
                    data = JSON.parse(RestClient.get "https://api.coinmarketcap.com/v1/ticker/#{coin.name}")[0]
                    message=
                    "Name: #{data['name']},
                    Symbol: #{data['symbol']},
                    USD price: #{data['price_usd']},
                    BTC price: #{data['price_btc']},
                    24H Change Percent: #{data['percent_change_24h']}%.
                    "
                    send_text_message(sender, message)
                  else
                    send_text_message(sender, "Sorry, I don't support this Cryptocurrency.")
                  end
                  # The AI is broken now...
                  # request =  Nokogiri::HTML(RestClient.post 'https://kakko.pandorabots.com/pandora/talk?botid=f326d0be8e345a13&skin=chat', :botcust2 => '80710b3efe026b98', :message => text)
                  # response = request.css('b')[2].next
                end
            end
          end
        elsif(event[:postback] && postback = event[:postback][:payload])
          case postback
            when 'Greet'
              default_message(sender)
            when 'Skills'
              send_text_message(sender, '發摟我，每天給最Hot虛擬貨幣資訊')  
            when 'Cryptocurrency'
              send_text_message(sender, 'I support more than 1500 Cryptocurrency tracing!!!
                Just input which coin info u wanna know!!!!')  
            when 'Start'
              start = {
                "text": "我是藍佛，有何貴幹？",
                "quick_replies":[
                  {
                    "content_type": "text",
                    "title": "打個招呼",
                    "payload": "Greet"
                  },
                  {
                    "content_type": "text",
                    "title": "買個鞋吧",
                    "payload": "Shoes"
                  },
                  {
                    "content_type": "text",
                    "title": "我想看妳會什麼",
                    "payload": "Skills"
                  },
                ]
              }
              send_generic_message(sender, start)
            when 'Shoes'
              sale_shoes(sender)
          end  
        end        
      end
    end
   render :body => nil, :status => 200, :content_type => 'text/html'
   return
  end

  def error
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end