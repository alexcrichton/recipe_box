Recipes::Application.routes.draw do
  resources :recipes do
    collection do
      post 'search'
      get 'search(/:q)' => 'recipes#search', :as => 'search'
      get :category_search
      get :ingredient_search
    end
  end

  devise_for :users

  match 'auth/facebook/callback' => 'authentications#create'

  root :to => 'recipes#box'
end
