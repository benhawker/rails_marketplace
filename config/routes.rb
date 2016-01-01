Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'

   resources :users do
  	get :watchlist
    get :offers
  end

  resources :inquiries do
    resources :messages
  end

	resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :restore
    end
  end

  get 'tags/:tag', to: 'listings#show', as: :tag

  resources :users do
    resources :feedbacks, shallow: true
  end

  resources :listings do
    resources :offers
  	post :watch
  	delete :unwatch
  end

  PagesController.action_methods.each do |action|
    get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  end

  # get "*any", via: :all, to: "errors#not_found"
end
