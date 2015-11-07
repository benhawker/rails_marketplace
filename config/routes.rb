Rails.application.routes.draw do
  
  devise_for :users
  root to: "home#index"

   resources :users, only: [:show, :index] do
    resource :profile, only: [:show, :edit, :update]
  	get :watchlist
  end

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

  get 'tags/:tag', to: 'listings#show', as: :tag

  resources :listings do
  	post :watch
  	delete :unwatch
  end

  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end


  # get "*any", via: :all, to: "errors#not_found"
end
