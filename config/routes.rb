Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'application#index'

  # GOUVEOLE
  get '/gouveole_registrations' => 'gouveole_registrations#new'
  get '/gouveole_registrations/admin(.:format)', to: 'gouveole_registrations#admin', as: 'gouveole_admin'

  resources :gouveole_registrations do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # 6ème Journée de psychiatrie (Mai 2014)
  get '/psy14_registrations' => 'psy14_registrations#new'
  get '/psy14_registrations/admin(.:format)', to: 'psy14_registrations#admin', as: 'psy14_admin'

  resources :psy14_registrations do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  #OTHER
  #...

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
