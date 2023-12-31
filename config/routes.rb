Rails.application.routes.draw do
    authenticated :user do
        root :to => "tasks#index", :as => "user_authenticated_root"
    end
    root to: "homes#index"
    devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
    resources :users do
        member do
            get :followings, :followers
        end
        resource :relationships, only: [:create, :destroy]
    end
    get 'users/:id/all_task', to: 'users#user_tasks'

    resources :tasks, except: [:index]
    
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :show]
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
end

