# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get 'login', to: 'session#index'
  post 'login', to: 'session#create'
  get 'profile' => 'users#profile'

  get 'logout' => 'session#destroy'

  get 'your_properties' => 'properties#show'
  get 'filtered_properties' => 'properties#index'
  post 'filtered_properties', to: 'properties#index'
  get 'interested_properties' => 'interested_users#interested_properties'
  post 'interested_properties' => 'interested_users#interested_properties'

  get 'approve_property/:id' => 'interested_users#approve', :as => :approve_property
  get 'remove_property/:id' => 'interested_users#remove', :as => :remove_property
  get 'unblock/:id' => 'properties#unblock', :as => :unblock_property
  resources :interested_users

  resources :users do
    get 'user_specific_comments' => 'comments#user_specific_comments'
    post 'user_specific_comments' => 'comments#user_specific_comments'
    resources :interested_users
  end
  resources :properties do
    resources :interested_users
    resources :comments
    get 'my_comments' => 'comments#my_comments'
    post 'my_comments' => 'comments#my_comments'
    get 'user_comments' => 'comments#index'
    post 'user_comments' => 'comments#index'
  end
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
