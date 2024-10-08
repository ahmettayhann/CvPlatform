Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: [:edit, :update] do
    member do
      delete 'purge_avatar'
    end
  end
  resources :resumes do
    collection do
      get :search
    end
    member do
      get :download
    end
  end

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  match '/logout', to: 'sessions#destroy', as: 'logout', via: [:get, :delete]

  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'sign_up', to: 'registrations#create'
      delete 'sign_out', to: 'authentication#sign_out'
      resources :resumes, only: [:index, :show]
    end
  end

end
