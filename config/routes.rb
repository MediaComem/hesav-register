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

  # 7ème Journée de psychiatrie (Avril 2015)
  get '/psy' => 'psy14_registrations#new'
  get '/psy/admin(.:format)', to: 'psy14_registrations#admin', as: 'psy14_admin'

  resources :psy14_registrations, path: 'psy' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Nursing2015 (Juin 2015)
  get '/nursing2015' => 'nursing15_registrations#new'
  get '/nursing2015/admin(.:format)', to: 'nursing15_registrations#admin', as: 'nursing15_admin'

  resources :nursing15_registrations, path: 'nursing2015' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Psy16 (Mai 2016)
  get '/psy16' => 'psy16_registrations#new'
  get '/psy16/admin(.:format)', to: 'psy16_registrations#admin', as: 'psy16_admin'

  resources :psy16_registrations, path: 'psy16' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end
  # get '/scientifique14_registrations' => 'death14_registrations#new'
  # get '/scientifique14_registrations/admin(.:format)', to: 'death14_registrations#admin', as: 'death14_admin'
  
  # resources :death14_registrations, path: 'scientifique14_registrations' do
  #   collection do
  #     get 'new'
  #     get 'accepted'
  #     get 'exception'
  #     get 'decline'
  #     get 'cancel'
  #     get 'cgv'
  #   end
  # end


  # Journées d'étude du 8-9 octobre
  get '/etu14_registrations' => 'etu14_registrations#new'
  get '/etu14_registrations/admin(.:format)', to: 'etu14_registrations#admin', as: 'etu14_admin'

  resources :etu14_registrations do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Soigner la mort le 3 novembre
  get '/scientifique14_registrations' => 'death14_registrations#new'
  get '/scientifique14_registrations/admin(.:format)', to: 'death14_registrations#admin', as: 'death14_admin'

  resources :death14_registrations, path: 'scientifique14_registrations' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Journées scientifiques 2016
  get '/js16' => 'js16_registrations#new'
  get '/js16/admin(.:format)', to: 'js16_registrations#admin', as: 'js16_admin'

  resources :js16_registrations, path: 'js16' do
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
