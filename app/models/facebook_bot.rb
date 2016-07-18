class FacebookBot

  def send_message(data)

    url = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=#{Settings.Messenger_api.access_token}")

    http = Net::HTTP.new(url.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE #only for development.
    begin
      request = Net::HTTP::Post.new(url.request_uri)
      request["Content-Type"] = "application/json"
      request.body = data.to_json
      response = http.request(request)
      body = JSON(response.body)
      return { ret: body["error"].nil?, body: body }
    end
  end

  def send_text_message(sender, text)
    data = {
      recipient: { id: sender},
      message: { text: text}
    }
    send_message(data)
  end

  def send_generic_message(sender, mes)
    data = {
      recipient: { id: sender },
      message: mes
    }
    send_message(data)
  end

  def default_message(sender)
    mes = {
      "text":"嗨～我是藍佛:",
      "quick_replies":[
        {
          "content_type":"text",
          "title":"早安",
          "payload":"早安"
        },
        {
          "content_type":"text",
          "title":"午安",
          "payload":"午安"
        },
        {
          "content_type":"text",
          "title":"晚安",
          "payload":"晚安"
        }
      ]
    }
    send_generic_message(sender, mes)
  end

  def sale_shoes(sender)
    shoes = {
      attachment: {
        type: "template",
        payload: {
          template_type: "generic",
            elements: [{
            title: "彩色勾勾",
            subtitle: "彩色Nike",
            item_url: "https://www.google.com.tw/search?q=%E9%9E%8B%E5%AD%90&espv=2&biw=1280&bih=729&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjey_bA8fTNAhUJJpQKHbkBCBQQ_AUIBigB#imgrc=QNFl4XNYQEEXKM%3A",               
            image_url: "http://down1.sucaitianxia.com/ai/20/ai4095.jpg",
            buttons: [{
              type: "web_url",
              url: "https://www.google.com.tw/search?q=%E9%9E%8B%E5%AD%90&espv=2&biw=1280&bih=729&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjey_bA8fTNAhUJJpQKHbkBCBQQ_AUIBigB#imgrc=QNFl4XNYQEEXKM%3A",
              title: "前往選購"
            }, {
              type: "postback",
              title: "讓我看妳還會什麼",
              payload: "Skills"
            }],
          }, {
            title: "踢不爛",
            subtitle: "Timberland",
            item_url: "https://www.google.com.tw/search?espv=2&biw=1280&bih=685&tbm=isch&sa=1&q=timberland&oq=Timber&gs_l=img.3.0.0l10.139579.141876.0.142513.13.11.1.1.1.0.57.473.11.11.0....0...1c.1j4.64.img..0.8.276.aiodn-bjRbc#imgrc=aNE7b6kAk11o4M%3A",               
            image_url: "https://images.timberland.com/is/image/timberland/10061024-HERO?$PLP-IMAGE$",
            buttons: [{
              type: "web_url",
              url: "https://www.google.com.tw/search?espv=2&biw=1280&bih=685&tbm=isch&sa=1&q=timberland&oq=Timber&gs_l=img.3.0.0l10.139579.141876.0.142513.13.11.1.1.1.0.57.473.11.11.0....0...1c.1j4.64.img..0.8.276.aiodn-bjRbc#imgrc=aNE7b6kAk11o4M%3A",
              title: "前往選購"
            }, {
              type: "postback",
              title: "還會別的？",
              payload: "Skills"
            }]
          }]
        }
      }
    }
    send_generic_message(sender, shoes)    
  end

  def bamboo_trace(sender)
    shoes = {
      attachment: {
        type: "template",
        payload: {
          template_type: "generic",
            elements: [{
            title: "彩色勾勾",
            subtitle: "彩色Nike",
            item_url: "http://bamboo.villager.website/?customer=#{sender}",               
            image_url: "http://down1.sucaitianxia.com/ai/20/ai4095.jpg",
            buttons: [{
              type: "web_url",
              url: "http://bamboo.villager.website/?customer=#{sender}",
              title: "前往選購"
            }, {
              type: "postback",
              title: "讓我看妳還會什麼",
              payload: "Skills"
            }],
          }, {
            title: "踢不爛",
            subtitle: "Timberland",
            item_url: "http://bamboo.villager.website/?customer=#{sender}",               
            image_url: "https://images.timberland.com/is/image/timberland/10061024-HERO?$PLP-IMAGE$",
            buttons: [{
              type: "web_url",
              url: "http://bamboo.villager.website/?customer=#{sender}",
              title: "前往選購"
            }, {
              type: "postback",
              title: "還會別的？",
              payload: "Skills"
            }]
          }]
        }
      }
    }
    send_generic_message(sender, shoes)    
  end

  def good_morning(sender)
    image = {
      "attachment":{
        "type":"image",
        "payload":{
          "url":"http://front-pic.style.fashionguide.com.tw/uploads/share/picture/222352/share_picture_1359999787.jpg"
        }
      }
    }
    send_generic_message(sender, image)
  end

  def good_afternoon(sender)
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
              payload: "Greet"
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
              payload: "Greet"
            }]
          }]
        }
      }
    }
    send_generic_message(sender, option)
  end

  def good_night(sender)
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
              "payload": "Greet"
            }
          ]
        }
      }
    }  
    send_generic_message(sender, button) 
  end

  def broadcast(message)
    User.all.each do |user|
      send_text_message(user.fb_id,message)
    end
  end
end
