class User < ApplicationRecord
  after_update :sending_message

  def sending_message
    FacebookBot.new.send_text_message(self.fb_id, self.ai_response)
  end
end
