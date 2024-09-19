Rails.application.routes.draw do
  root 'home#index'

  resources :users
  resources :resumes do
    collection do
      get :search
    end
  end

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  namespace :api do
    namespace :v1 do
      resources :resumes, only: [:index, :show]
    end
  end

end
