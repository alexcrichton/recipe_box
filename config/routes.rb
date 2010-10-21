Recipes::Application.routes.draw do
  scope '(:user_id)' do
    resources :recipes, :shallow => true do
      collection do
        post 'search'
        get 'search(/:q)' => 'recipes#search', :as => 'search'
        get :category_search
        get :ingredient_search
      end
    end
  end

  devise_for :users

  match 'auth/facebook/callback' => 'authentications#create'

  root :to => 'recipes#box'
end
