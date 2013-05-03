Alphanumeric::Application.routes.draw do

  get "assigned/index"

  mount Ckeditor::Engine => '/ckeditor'
  scope "/staff" do
    match '/history/editor', to: 'history#editor', :via => :get, as: 'history_editor'
    match '/history/contributor', to: 'history#contributor', :via => :get, as: 'history_contributor'
    match '/history/editor/articles/:id', to: 'articles#show', :via => :get, as: 'history_editor_article'
    match '/history/contributor/articles/:id', to: 'articles#show', :via => :get, as: 'history_contributor_article'
    match '/published', to: 'published#index', :via => :get, as:'published_index' 
    match '/published', to: 'published#index', :via => :get, as:'published_index' 
    match '/published/articles/:id' => 'articles#show', :via => :get, as: 'published_article'
    match '/archived', to: 'archived#index', :via => :get, as:'archived_index'
    match '/archived/articles/:id' => 'articles#show', :via => :get, as: 'archived_article'
    resources :published, :only => [:index] 
    resources :articles do
      get :autocomplete_tag_name, :on => :collection
      get :autocomplete_issue_name, :on => :collection
      get :autocomplete_contributor_last_name, :on => :collection
      get :autocomplete_editor_last_name, :on => :collection
    end
    resources :account_creates 
    resources :reset_password, :only => [:new, :create, :edit, :update]
    resources :sessions
    resources :employees, :only => [:new, :create, :show, :edit, :update, :index]
    match '/employees/:id/admin_edit/' => 'employees#edit', :via => :get, as: 'edit_administrative_employee'
    match '/employees/:id/admin_edit/' => 'employees#update', :via => :put, as: 'edit_administrative_employee'
    match '/edit_personal' => 'employees#edit', :via => :get, as: 'edit_personal_info'
    match '/edit_personal' => 'employees#update', :via => :put, as: 'edit_personal_info'
    scope "/workspace" do
      match '/draft/new/' => 'articles#new', :via => :get, as: 'draft_new_article'
      match '/assign/new/' => 'articles#new', :via => :get, as: 'assign_new_article'
      match '/draft/new/' => 'articles#create', :via => :post, as: 'post_new_draft'
      match '/assign/new/' => 'articles#create', :via => :post, as: 'post_new_assign'
      resources :articles, :except => [:index, :new, :create], as: 'workspace_article'
      resources :incomplete, :only => [:index], as: 'incomplete_workspace' 
      resources :assigned, :only => [:index], as: 'assigned_workspace'
      resources :review, :only => [:index], as: 'review_workspace' 
      resources :approved, :only => [:index], as: 'approved_workspace' 
      resources :published, :only => [:index], as: 'published_workspace' 
    end
    match '/update_status', to: 'articles#update_status', :via => :post, as: 'update_status'
    match '/insert_article', to: 'articles#insert_article', :via => :post, as: 'staff_insert_article'
    match '/publish_articles', to: 'articles#publish_articles', :via => :post, as: 'publish_articles'
    match 'archive_articles', to: 'articles#archive_articles', :via => :post, as: 'archive_articles'
    match '/sign_out', to: 'sessions#destroy', as: 'log_out'
    match '/home', to: 'home#show', as: 'home'
    match '/search_articles', to: 'articles#search_articles', :via => :get
    match "/assign_random", to:"articles#random", :via=> :post, as: "assign_random"
    match "/add_to_the_article", to:"articles#add_to_the_article", :via => :get
    get 'tags/:tag', to: 'list#index', as: :tag
    match '/employees', to: 'employees#index', :via => :post, as: 'employees'
    match '/list', to: 'list#index', as: 'list'
    match '/', to: 'sessions#new', as: 'root_uploader'
  end

  match '/sign_out', to: 'sessions#destroy', as: 'log_out'
  match '/newsbox', to: 'published#index', as: 'user_home'
  match '/signup', to: 'users#new', :via=> :get, as: 'signup'
  match '/published', to: 'published#index', :via => :get, as:'user_published_index' 
  match '/published/articles/:id' => 'articles#show', :via => :get, as: 'user_published_article'
  match '/archived', to: 'archived#index', :via => :get, as:'user_archived_index'
  match '/archived/articles/:id' => 'articles#show', :via => :get, as: 'user_archived_article'
  get 'tags/:tag', to: 'list#index', as: 'user_tag'
  resources :users, :only => [:create, :edit, :update, :show]
  match '/archive_for_user', to: 'articles#archive_for_user', as: 'archive_for_user'
  root to: 'sessions#new'  
  resources :reset_password, :only => [:new, :create, :edit, :update], as: 'user_reset_password'
  match '/login', to: 'sessions#create', :via=> :post, as:"login_post"
  match '/user_action', to: 'articles#user_action', :via=> :post, as:'user_action'
  match '/insert_article', to: 'articles#insert_article', :via=> :post, as: 'insert_article'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
