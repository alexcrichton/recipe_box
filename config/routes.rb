BdayRecipes::Application.routes.draw do
  resources :recipes do
    collection do
      post 'search'
      get 'search(/:q)' => 'recipes#search', :as => 'search'
      get :category_search
      get :ingredient_search
    end
  end

  root :to => 'recipes#box'
end
