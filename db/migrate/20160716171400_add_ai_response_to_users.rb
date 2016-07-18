class AddAiResponseToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ai_response, :text
  end
end
