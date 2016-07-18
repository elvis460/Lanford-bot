namespace :events do
  task dinner_broadcast: :environment do
    User.all.each do |user|
      FacebookBot.new.send_text_message(user.fb_id, "記得吃晚餐，單身狗們")
    end
  end
  task night_broadcast: :environment do
    User.all.each do |user|
      FacebookBot.new.send_text_message(user.fb_id, "晚安，睡覺要想我")
    end
  end
end