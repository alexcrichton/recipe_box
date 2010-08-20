Recipes::Application.routes.draw do
  resources :recipes do
    collection do
      post 'search'
      get 'search(/:q)' => 'recipes#search', :as => 'search'
    end
  end

  root :to => 'recipes#box'
end
