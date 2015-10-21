Rails.application.routes.draw do
  
  devise_for :users
  root to: "home#index"
  
  resources :users, only: [:show, :index]

  resources :messages, only: [:new, :create]
  
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      post :mark_as_read
    end
    collection do
      delete :empty_trash
    end
  end

	resources :conversations, only: [:index, :show, :destroy] do
  member do
    post :restore
  end
end

  resources :listings do
  	post :watch
  end

  # get "*any", via: :all, to: "errors#not_found"
end
