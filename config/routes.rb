Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  authenticate :user do
  	resources :games
  	get "/users/show_users" => "users#index"
  	get "/show_users/:id" => "users#show" , :as => :show_user
  	get "/buy_game" => "games#buy_game"
  end
  root to: "games#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
