Rails.application.routes.draw do
  get 'bookmarks/create'
  get 'bookmarks/destroy'
  root 'static_pages#top'

  get  'login'  => 'user_sessions#new', :as => :login
  post 'login'  => 'user_sessions#create'
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users,  only: %i[new create]
  resources :boards do
    resources :comments, only: %i[show edit create update destroy], shallow: true
    resource  :bookmarks, only: %i[create destroy]
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
end
