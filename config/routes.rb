ActionController::Routing::Routes.draw do |map|
  # ROOT
  map.root :controller => 'static_page', :action => 'index'

  # LOGIN/LOGOUT
  map.resource  :user_session
  map.resource  :registration, :only => [:edit, :update]
  map.logout    'logout', :controller => 'user_sessions', :action => 'destroy'
  map.resources :password_resets, :only => [:create, :edit, :update]

  # PROFILE
  map.resource :profile, :only => [:edit, :update, :disable_tips],
    :member => {:disable_tips => :put}

  # STATIC PAGES
  map.about_page 'about', :controller => 'static_page',
    :action => 'about'

  map.resources :comments
  map.resources :reports, :only => [:index]

  # ALL USERS
  map.dashboard 'dashboard', :controller => 'dashboard', :action => :index
  map.set_request 'set_request/:id', :controller => 'users', :action => :set_request

  # ADMIN
  map.namespace :admin do |admin|
    admin.resources :requests
    admin.resources :responses, :only => [:index]
    admin.resources :organizations,
      :collection => {:duplicate => :get, :remove_duplicate  => :put,
                      :download_template => :get, :create_from_file => :post}
    admin.resources :reports,
      :member => { :generate => :get },
      :collection => { :mark_implementer_splits => :put}
    admin.resources :documents, :as => :files
    admin.resources :currencies, :only => [:index, :new, :create, :update, :destroy]
    admin.resources :users, :except => [:show],
      :collection => {:create_from_file => :post, :download_template => :get}
    admin.resources :codes,
      :collection => {:create_from_file => :post, :download_template => :get}
    admin.resources :comments
  end

  # ACTIVITY MANAGER
  map.activity_manager_workplan 'activity_manager/workplan', :controller => 'users', :action => :activity_manager_workplan

  # REPORTER USER: DATA ENTRY
  map.resources :responses,
    :except => [:index, :new, :create, :edit, :update, :destroy],  # yeah, ridicuI know.
    :member => {:review => :get, :submit => :put,
                :restart => :put, :send_data_response => :put,
                :approve_all_budgets => :put,
                :reject => :put, :accept => :put} do |response|
    response.resources :projects, :except => [:show],
      :collection => {:download_template => :get,
                      :export_workplan => :get,
                      :export => :get,
                      :import => :post,
                      :import_and_save => :post}
    response.resources :activities, :except => [:index, :show],
      :member => {:sysadmin_approve => :put, :activity_manager_approve => :put},
      :collection => {:template => :get,
                      :export => :get}
    response.resources :other_costs, :except => [:index, :show],
      :collection => {:create_from_file => :post, :download_template => :get}
    response.resources :districts, :only => [:index, :show] do |district|
      district.resources :activities, :only => [:index, :show],
        :controller => "districts/activities"
      district.resources :organizations, :only => [:index, :show],
        :controller => "districts/organizations"
    end

    response.resources :reports, :only => [:index, :show]

    response.resources :documents, :as => :files
  end

  map.resources :activities
  map.resources :organizations, :only => [:edit, :update],
    :collection => { :export => :get }

  map.namespace :reports do |reports|
    reports.resources :responses, :only => [] do |response|
      response.resources :projects, :only => [],
        :member => {:overview => :get}
      response.resources :organizations, :only => [],
        :member => {:overview => :get}
    end
  end
end
