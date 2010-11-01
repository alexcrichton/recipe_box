RecipeBox::Application.routes.draw do
  user_regex = /[^\/]+/

  scope ':user_id', :as => 'user', :constraints => {:user_id => user_regex } do
    resources :recipes, :only => [:index, :show] do
      collection do
        post 'search'
        get 'search(/:q)' => 'recipes#search', :as => 'search'
      end
      resources :comments, :only => [:new, :index, :create]
    end
  end

  resources :recipes do
    collection do
      post 'search'
      get 'search(/:q)' => 'recipes#search', :as => 'search'
      get :category_search
      get :ingredient_search
    end

    resources :comments, :only => [:new, :index, :create]
  end

  get 'friends' => 'users#friends'
  devise_for :users

  match 'auth/facebook/callback' => 'authentications#create'

  get ':user_id' => 'recipes#box', :user_id => user_regex, :as => 'user'
  root :to => 'recipes#box'
end
