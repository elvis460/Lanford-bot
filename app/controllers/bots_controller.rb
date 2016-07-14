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
              when '早安'
                image = {
                  "attachment":{
                    "type":"image",
                    "payload":{
                      "url":"http://front-pic.style.fashionguide.com.tw/uploads/share/picture/222352/share_picture_1359999787.jpg"
                    }
                  }
                }
                FacebookBot.new.send_generic_message(sender, image)
              when '午安'
                option = {
                  attachment: {
                    type: "template",
                    payload: {
                      template_type: "generic",
                        elements: [{
                        title: "藍佛是我",
                        subtitle: "我是藍佛",
                        item_url: "https://www.facebook.com/yiwen.lan.10",               
                        image_url: "https://www.villager.website/assets/lanford_2-f2dec8ef23df59c06ce0f4a02c6f8741cdf94f8aebe2ede16f7772866b3d5118.jpg",
                        buttons: [{
                          type: "web_url",
                          url: "https://www.facebook.com/yiwen.lan.10",
                          title: "誠徵男友"
                        }, {
                          type: "postback",
                          title: "跟我聊",
                          payload: "TalkToMe"
                        }],
                      }, {
                        title: "Lanford is me",
                        subtitle: "I'm Lanford",
                        item_url: "https://www.facebook.com/yiwen.lan.10",               
                        image_url: "https://www.villager.website/assets/lanford_1-bb6b5025f112643b61739e620b7ab07063ea19b4d2e07cf76a5d13e5db77ff4e.jpg",
                        buttons: [{
                          type: "web_url",
                          url: "https://www.facebook.com/yiwen.lan.10",
                          title: "See Me !!!"
                        }, {
                          type: "postback",
                          title: "跟我聊",
                          payload: "TalkToMe"
                        }]
                      }]
                    }
                  }
                }
                FacebookBot.new.send_generic_message(sender, option)  
              when '晚安'
                button = {
                  "attachment":{
                    "type": "template",
                    "payload":{
                      "template_type": "button",
                      "text": "我是藍佛，藍佛是我",
                      "buttons":[
                        {
                          "type": "web_url",
                          "url": "https://www.facebook.com/yiwen.lan.10",
                          "title": "看我看我"
                        },
                        {
                          "type": "postback",
                          "title": "跟我聊",
                          "payload": "TalkToMe"
                        }
                      ]
                    }
                  }
                }  
                FacebookBot.new.send_generic_message(sender, button) 
            end
          else
            case text
              when 'hello'
                FacebookBot.new.send_text_message(sender, "I'm Lanford.")               
              else
                mes = {
                  "text": "嗨～我是藍佛:",
                  "quick_replies":[
                    {
                      "content_type": "text",
                      "title": "早安",
                      "payload": "早安"
                    },
                    {
                      "content_type": "text",
                      "title": "午安",
                      "payload": "午安"
                    },
                    {
                      "content_type": "text",
                      "title": "晚安",
                      "payload": "晚安"
                    }
                  ]
                }
                FacebookBot.new.send_generic_message(sender, mes)
            end
          end
        elsif(event[:postback] && postback = event[:postback][:payload])
          case postback
            when 'TalkToMe'
              FacebookBot.new.default_message(sender)
          end 
        end        
      end
    end
   render :body => nil, :status => 200, :content_type => 'text/html'
   return
  end
end