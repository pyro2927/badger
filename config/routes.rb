Badger::Application.routes.draw do
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  resources :badges
  resources :achievements, :only => [:index, :show, :destroy]
  post '/users/:user_id/badges/:badge_id' => 'achievements#create', :as => :new_achievement
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
