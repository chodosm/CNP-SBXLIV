ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.connect '/alive.html', :controller => "status"
  map.resources 'vap', :controller => "vap_requests"
  
  # Rails 2.0ish
   map.namespace(:admin) do |admin|
     admin.resources :vap_requests
   end
  
  map.login '/admin/login', :controller => "sessions", :action => "new"
  map.logout '/admin/logout', :controller => "sessions", :action => "destroy"
  
  map.resource :session, :controller => "sessions"
  
  # Rails 1.2.3ish
  map.resource :admin do |admin|
    admin.resources :vap_requests,
      :controller       => "admin/vap_requests",
      :prefix           => "admin_",
      :has_many         => "vap_request_days",
      :collection       => {:csv => :get},
      :member           => {:resend => :get},
      :active_scaffold  => true
      
    admin.resources :vap_days,
      :controller       => "admin/vap_days",
      :prefix           => "admin_",
      :active_scaffold  => true
    
    admin.resources :vap_request_days,
      :controller       => "admin/vap_request_days",
      :prefix           => "admin_",
      :active_scaffold  => true
  end
  
  #map.nflol '/nflol', :controller => "nflol"
  map.nflol '/nflol', :controller => "flow", :action => 'nflol'
  map.connect '/nflol/validate', :controller => "nflol", :action => "validate"
  map.sap '/sap',     :controller => 'flow', :action => 'sap'
  #map.vap '/vap',     :controller => 'flow', :action => 'vap'
  map.nflx '/nflx',   :controller => 'flow', :action => 'nflx'
  map.dog '/dog',     :controller => 'flow', :action => 'dog'
  map.superbowl '/superbowl',     :controller => 'flow', :action => 'superbowl'
  map.probowl '/probowl',     :controller => 'flow', :action => 'probowl'
  map.staff '/staff',     :controller => 'flow', :action => 'staff'
  map.connect '',     :controller => 'flow', :action => 'index'  
  map.connect ':action', :controller => 'flow'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
