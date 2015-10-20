Rails.application.routes.draw do
  
  devise_for :users
  root to: "home#index"
  
  resources :listings do
  	post :watch
  end

  # get "*any", via: :all, to: "errors#not_found"
end
