Rails.application.routes.draw do
  resources :credentials
	root to: "home#index"

	devise_for :users

	resources :users
	resources :events


	post '/register/:event_id/:user_id', to: 'events#register_user', as: :register_user
	get '/remove_register/:event_id/:user_id', to: 'events#remove_register_user', as: :remove_register_user

	get '/dashboard', to: 'home#dashboard', as: :dashboard

	get "*unmatched_route" => "errors#not_found", as: :page_not_found

end


