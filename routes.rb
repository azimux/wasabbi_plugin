ActionController::Routing::Routes.draw do |map|
  map.resources :wasabbi_forum_string_options
  map.resources :wasabbi_forums
  map.resources :wasabbi_threads
  map.resources :wasabbi_posts
  map.resources :wasabbi_adminships
  map.resources :wasabbi_modships
  map.resources :wasabbi_users, :only => [:show]
  map.resources :wasabbi_ranks

  map.wasabbi_denied_admin "wasabbi_static/denied_admin",
    :controller => "wasabbi_static", :action => "denied_admin"
  map.wasabbi_denied_mod "wasabbi_static/denied_mod",
    :controller => "wasabbi_static", :action => "denied_mod"
  map.wasabbi_denied_member "wasabbi_static/denied_member",
    :controller => "wasabbi_static", :action => "denied_member"
  map.wasabbi_not_last "wasabbi_static/cant_delete_not_last",
    :controller => "wasabbi_static", :action => "cant_delete_not_last"

  map.wasabbi_problem "wasabbi_problem",
    :controller => "wasabbi_problems", :action => "show"
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  #  map.connect ':controller/:action/:id'
  #  map.connect ':controller/:action/:id.:format'
end
