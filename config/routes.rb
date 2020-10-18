Rails.application.routes.draw do

  root 'static_pages#top'
#  root :to => 'users#index'

  get  'static_pages/top'
    
  resources :users
  get  'login'  => 'user_sessions#new',     :as => :login
  post 'login'  => 'user_sessions#create'
  post 'logout' => 'user_sessions#destroy', :as => :logout

end
