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

end
