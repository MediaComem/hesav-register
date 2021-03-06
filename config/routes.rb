Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'application#index'

  resources :charges

  # Jpys19 (Mars 2019)
  get '/psy' => 'jpsy19_registrations#new'
  get '/psy/admin(.:format)', to: 'jpsy19_registrations#admin', as: 'jpsy19_admin'

  resources :jpsy19_registrations, path: '/psy' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Symposium18 (Avril 2018)
  get '/symposium18' => 'symposium18_registrations#new'
  get '/symposium18/admin(.:format)', to: 'symposium18_registrations#admin', as: 'symposium18_admin'

  resources :symposium18_registrations, path: 'symposium18' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Jpsy18 (Février 2018)
  get '/jpsy18' => 'jpsy18_registrations#new'
  get '/jpsy18/admin(.:format)', to: 'jpsy18_registrations#admin', as: 'jpsy18_admin'

  resources :jpsy18_registrations, path: 'jpsy18' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end


  # 3ème journée latine du soin psychique de l’ARIP-HESAV
  get '/psy17' => 'psy17_registrations#new'
  get '/psy17/admin(.:format)', to: 'psy17_registrations#admin', as: 'psy17_admin'

  resources :psy17_registrations, path: 'psy17' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
    end
  end

  # Journée Scientifique 2017
  get '/js17' => 'js17_registrations#new'
  get '/js17/admin(.:format)', to: 'js17_registrations#admin', as: 'js17_admin'

  resources :js17_registrations, path: 'js17' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Autonomie et responsabilité des sages-femmes en milieu hospitalier
  get '/auto17' => 'auto17_registrations#new'
  get '/auto17/admin(.:format)', to: 'auto17_registrations#admin', as: 'auto17_admin'

  resources :auto17_registrations, path: 'auto17' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

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
  get '/psy14' => 'psy14_registrations#new'
  get '/psy14/admin(.:format)', to: 'psy14_registrations#admin', as: 'psy14_admin'

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

  # Jpsy16 (Novembre 2016)
  get '/jpsy16' => 'jpsy16_registrations#new'
  get '/jpsy16/admin(.:format)', to: 'jpsy16_registrations#admin', as: 'jpsy16_admin'

  resources :jpsy16_registrations, path: 'jpsy16' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
      get 'cgv'
    end
  end

  # Trm30 (Juin 2017)
  get '/trm30ans' => 'trm30_registrations#new'
  get '/trm30ans/admin(.:format)', to: 'trm30_registrations#admin', as: 'trm30_admin'

  resources :trm30_registrations, path: 'trm30' do
    collection do
      get 'new'
      get 'accepted'
      get 'exception'
      get 'decline'
      get 'cancel'
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
