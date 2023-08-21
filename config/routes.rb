Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'albums#home'
  
  get "/album_search", to: "albums#show"

  post "/add_favorite", to: "albums#add_favorite"
end
