Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'bots#index'
  get 'bots/webhook' => 'bots#webhook'
  post 'bots/webhook' => 'bots#receive_message'

  resources :backends,only: [:index]
  namespace :backends do
    resources :sessions , only: [:index,:create,:destroy]
    resources :users , only: [:index]
    get 'actions/product_button/:id' , to: 'actions#product_button', as: 'show_product_button'
    resources :actions
  end
  get "*any", via: :all, to: "bots#error"
end
