Badger::Application.routes.draw do
  get "badges/show"
  get "badges/index"
  get "badges/edit"
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  resources :badges
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
