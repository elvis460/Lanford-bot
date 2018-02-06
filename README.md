# Messenger Bot 

Ref [Messenger API](https://developers.facebook.com/docs/messenger-platform/quickstart) and built a Messenger Bot with Rails

## APIs Used in [Send API](https://developers.facebook.com/docs/messenger-platform/send-api-reference) 
* Image Attachment 
* Button Template
* Message Templates
* Persistent Menu
* Quick Replies

## Demo

Direct send message to [Landford-Bot](https://www.facebook.com/Lanford%E8%97%8D%E4%BD%9B-300602840279256/) or click any button and see what showed!!!

My Messenger Bot could answer you the price and the 24H-Changed-Percent of Cryptocurrency you input! Try it!


## Getting Started

If you wanna buid your own Messenger bot, follow the steps below.

### Install required ruby gems

bundle the ruby gems

```
bundle install
```


### Setting Facebook Webhook

* Besides the program, you need to set up Messenger API for your Fan Page on [Facebook for Developers](https://developers.facebook.com/). And I wrote [an article about initial setting up intro here](https://medium.com/@elvis4600/build-your-own-messenger-bot-e72dbf421ab9)
 
* In Facebook Webhook setting page, you should input the callback url (SSL required)

 `https://[your domin]/bots/webhook`


change the file  `config/settings.yml.sample` to `config/settings.yml` and 
update the `access_token` and `verify_token` in file

```
  Messenger_api:
    access_token: your_page_access_token
    verify_token: your_verify_token
 ```


* verify_token is for Facebook to check if your Website is work and legal(SSL required) now.


### Setting Persistent Menu

Use any tool or curl method in commandline to initial Persistent Menu

* post url 
```
 post https://graph.facebook.com/v2.6/me/messenger_profile?access_token=[your messenger access token]
```

* params body 

```
 {
  "persistent_menu":[
    {
      "locale":"default",
      "composer_input_disabled": false,
      "call_to_actions":[
        {
          "title":"Getting Start!!!",
          "type":"nested",
          "call_to_actions":[
            {
              "title":"Cryptocurrency",
              "type":"postback",
              "payload":"Cryptocurrency"
            },{
              "title":"Play with me.",
              "type":"postback",
              "payload":"Start"
            },
            {
              "title":"Greet",
              "type":"postback",
              "payload":"Greet"
            }
          ]
        }
      ]
    }
  ]
}
```

* If set `composer_input_disabled = true` will `disable` user input in your Messenger Bot
* `call_to_actions` should put your postback and payload you set in `bots_controller`


## Congrats! Your Bot is alive now!

You could do some change in `bots_controllers#receive_message` and `bots_helper` to create your own Bot.



