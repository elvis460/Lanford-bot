class BotsController < ApplicationController
  include BotsHelper
  skip_before_filter :verify_authenticity_token

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
        if (event[:message] && text = event[:message][:text])
          if (event[:message][:quick_reply] && payload = event[:message][:quick_reply][:payload])
            case payload
              when 'Greet'
                FacebookBot.new.default_message(sender)
              when 'Skills'
                FacebookBot.new.send_text_message(sender, '等等呢，我還在學習...')  
              when 'Shoes'
                FacebookBot.new.sale_shoes(sender)
              when '早安'
                FacebookBot.new.good_morning(sender)
              when '午安'
                FacebookBot.new.good_afternoon(sender)  
              when '晚安'
                FacebookBot.new.good_night(sender) 
            end
          else
            case text
              when 'hello'
                FacebookBot.new.send_text_message(sender, "I'm Lanford.") 
              when '鞋子'
                FacebookBot.new.sale_shoes(sender)     
              else
                FacebookBot.new.default_message(sender) 
            end
          end
        elsif(event[:postback] && postback = event[:postback][:payload])
          case postback
            when 'Greet'
              FacebookBot.new.default_message(sender)
            when 'Skills'
              FacebookBot.new.send_text_message(sender, '等等呢，我還在學習...')  
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
              FacebookBot.new.send_generic_message(sender, start)
            when 'Shoes'
              FacebookBot.new.sale_shoes(sender)
          end 
        end        
      end
    end
   render :body => nil, :status => 200, :content_type => 'text/html'
   return
  end
end