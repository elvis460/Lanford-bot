class BotsController < ApplicationController
  include BotsHelper
  skip_before_action :verify_authenticity_token
  require 'rest-client'
  require 'nokogiri'

  def index
  # request=  Nokogiri::HTML(RestClient.post 'https://kakko.pandorabots.com/pandora/talk?botid=f326d0be8e345a13&skin=chat', :botcust2 => '80710b3efe026b98', :message => "messenger api broken")
  # response = request.css('b')[2].next
  # render text: response
  # return
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
                FacebookBot.new.default_message(sender)
              when 'Skills'
                FacebookBot.new.send_text_message(sender, '等等呢，我還在學習...')  
              # when 'Shoes'
              #   FacebookBot.new.sale_shoes(sender)
              # when Action.first.name
              #   FacebookBot.new.do_action(sender, Action.first.name)
              when '早安'
                FacebookBot.new.good_morning(sender)
              when '午安'
                FacebookBot.new.good_afternoon(sender)  
              when '晚安'
                FacebookBot.new.good_night(sender) 
            end
          else
            if Action.all.map{|x| x.name}.index(text)
              FacebookBot.new.do_action(sender, text)
            else
              case text
                when Action.all.map{|x| x.name}
                  
                when 'hello'
                  FacebookBot.new.send_text_message(sender, "I'm Lanford.") 
                when '鞋子'
                  FacebookBot.new.sale_shoes(sender) 
                when 'trace'
                  FacebookBot.new.bamboo_trace(sender) 
                # when Action.first.name
                #   FacebookBot.new.do_action(sender, Action.first.name)    
                # when 'moduletest'
                #   FacebookBot.new.do_action(sender, Action.first.name)  
                else
                  # The AI is broken now...
                  # request =  Nokogiri::HTML(RestClient.post 'https://kakko.pandorabots.com/pandora/talk?botid=f326d0be8e345a13&skin=chat', :botcust2 => '80710b3efe026b98', :message => text)
                  # response = request.css('b')[2].next
                  User.find_by(fb_id: sender).update(ai_response: 'Bebug - AI broken but bot still alive.') 
              end
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

  def error
    render :file => 'public/404.html', :status => :not_found, :layout => false
  end
end