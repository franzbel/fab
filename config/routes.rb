Rails.application.routes.draw do
  # get 'maintenances/index'

  get 'periodical_inspections/new'

  resources :catalogues
  resources :aircrafts do
    member do
      get 'get_systems'
      get 'get_systems_list'
    end
  end
  resources :systems do
    member do
      get 'get_components'
      get 'get_components_list'
    end
  end

  resources :components do
    member do
      get 'get_inspections'
      get 'get_inspections_list'
    end
  end
  resources :inspections do
    member do
      get 'get_tools_list'
    end
  end
  resources :special_tools

  resources :intermediate_inspections
  resources :flight_sheets

  resources :first_inspections
  resources :second_inspections
  resources :twelve_months_inspections
  resources :periodical_inspections
  resources :scheduled_inspections
  resources :deteriorating_items
  resources :non_deteriorating_items

  resources :maintenances do
    member do
      get 'procedure'
    end
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
