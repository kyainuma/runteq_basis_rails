Rails.application.routes.draw do
  root 'static_pages#top'

  get  'login'  => 'user_sessions#new', :as => :login
  post 'login'  => 'user_sessions#create'
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users,  only: %i[new create]
  resources :boards, only: %i[index new create show edit update destroy] do
    resources :comments, only: %i[create update destroy], shallow: true
  end
end
