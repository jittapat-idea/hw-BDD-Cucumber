Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  post '/movies/search_tmdb' => 'movies#search_tmdb', :as => 'search_tmdb'
  
  # omniauth routes
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy', as: 'logout'

  
  # Twitter authentication routes
  get '/auth/twitter', as: 'auth_twitter'
  get '/auth/twitter/callback', to: 'sessions#twitter_callback'
end

