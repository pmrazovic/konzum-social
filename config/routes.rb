KonzumSocial::Application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
              controllers: {omniauth_callbacks: "authentications"}
  resources :authentications
  resources :dashboard do
    collection do
      get 'orders'
      get 'friends'
      get 'shopping_lists'
      get 'liked_products'
      get 'favorite_products'
      get 'recipes'
      get 'browse_customers'
    end
  end
  resources :categories
  resources :products do
    member do
      post 'share_on_facebook'
      post 'share_in_email'
    end
  end
  resources :users do
    member do
      get 'profile'
    end
  end
  resources :carts do
    member do
      post 'checkout'
    end
  end
  resources :cart_items
  resources :orders
  resources :friendships
  resources :likes
  resources :favorites
  resources :ingredients
  resources :recipes do
    member do 
      get 'add_all_to_cart'
    end
  end
  resources :shopping_lists do 
    member do 
      get 'add_all_to_cart'
    end
  end
  resources :list_items
  resources :list_users
  get "user/:id/profile/orders" => "users#profile_orders", :as => 'profile_orders'
  get "user/:id/profile/likes" => "users#profile_likes", :as => 'profile_likes'
  get "user/:id/profile/favorites" => "users#profile_favorites", :as => 'profile_favorites'
  get "user/:id/profile/recipes" => "users#profile_recipes", :as => 'profile_recipes'
  root :to => "dashboard#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
