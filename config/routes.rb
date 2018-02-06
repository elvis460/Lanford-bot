Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'bots/webhook' => 'bots#webhook'
  post 'bots/webhook' => 'bots#receive_message'
  get "*any", via: :all, to: "bots#error"
end
