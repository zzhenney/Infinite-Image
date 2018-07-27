Rails.application.routes.draw do

  resources :images do
    collection do
      match 'search' => 'images#search', via: [:get, :post], as: :search
    end
  end
  resources :users
  resources :home



  get 'home/index'
  #get 'pages/index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #This sets root page to index.
  root 'home#index'
  get "pages" => "pages#index"
  get "pages/:page" => "pages#show"
  get 'result' => 'images#result'
  get "upload" => "home#upload" #Linking upload page route

  #overriding clearance routes
  #clearance / login / registration
  #
  # Admin
  constraints Clearance::Constraints::SignedIn.new { |user| user.admin? } do
    root to: "admin#index", as: :admin_root
  end

  get '/sign_in', to: 'sessions#new', as: nil
  delete "/sign_out" => "sessions#destroy", as: nil
  get "/sign_up" => "users#new", as: nil

  #About Us routes
  get 'pages/index' => 'pages#index'
  get "/pages/:page" => "pages#show"

end
