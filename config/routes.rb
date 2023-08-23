Rails.application.routes.draw do
    authenticated :user do
        root :to => "tasks#index", :as => "user_authenticated_root"
    end
    root to: "homes#index"
    devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
    resources :users do
        resource :relationships, only: [:create, :destroy]
        get 'followings', on: :member
        get 'followers', on: :member
    end

    resources :tasks, except: %i[index]
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Defines the root path route ("/")
    # root "articles#index"
end

