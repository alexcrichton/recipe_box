Recipes::Application.routes.draw do
  resources :recipes, :shallow => true do
    collection do
      post 'search'
      get 'search(/:q)' => 'recipes#search', :as => 'search'
      get :category_search
      get :ingredient_search
    end
  end

  scope ':user_id', :as => 'user', :constraints => {:user_id => /[^\/]+/} do
    resources :recipes, :only => [:index, :show]
  end

  devise_for :users

  match 'auth/facebook/callback' => 'authentications#create'

  root :to => 'recipes#box'
end
