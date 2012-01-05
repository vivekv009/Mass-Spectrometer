SampleRails::Application.routes.draw do
  #resources :help
  match '/help', :controller => 'help', :action => "index"


  devise_for :users, :path_prefix => 'secure',skip: :registrations do
  # Do not allow users to delete themselves
  # Only selectively give them operations they can perform
  resource :registration,
    only: [:new, :create, :edit, :update],
    path: 'secure/users',
    path_names: { new: 'sign_up' },
    controller: 'devise/registrations',
    as: :user_registration do
    get :cancel
    end
  end
  
  # matching routes for enabling, disabling and destroying a database version
  match '/database_versions/:id/disable', :controller => 'database_versions', :action => "disable", :as => "database_versions_disable"
  match '/database_versions/:id/enable', :controller => 'database_versions', :action => "enable", :as => "database_versions_enable"
  match '/database_versions/:id/destroy', :controller => 'database_versions', :action => "destroy", :as => "database_versions_destroy"

  match '/databases/:id/versions', :controller => 'databases', :action => "show_versions", :as => "database_versions_show"
  match '/databases/:id/version/:id', :controller => 'databases', :action => "show_version", :as => "database_version_show"
 
  # matching routes for enabling, disabling and destorying a whole database 
  match '/databases/:id/disableall', :controller => 'databases', :action => "disableall", :as =>"databases_disableall"
  match '/databases/:id/enableall', :controller => 'databases', :action => "enableall", :as =>"databases_enableall"
  match '/databases/:id/destroyall', :controller => 'databases', :action => "destroyall", :as => "databases_destroyall"
  
  
  match '/users/manage', :controller => 'users', :action => "index"
  match '/users/new', :controller => 'users', :action => "new", :as => "new_user" 
  match '/users/approve/:user', :controller => 'users', :action => "approve", :as => "users_approve"
  match '/users/enable/:user', :controller => 'users', :action => "enable", :as => "users_enable"
  match '/users/disable/:user', :controller => 'users', :action => "disable", :as => "users_disable"
  resources :users 
  
  resources :databases
  # for editing the database name only --> no files are uploaded .. 
  match '/databases/:id/editDatabaseName', :controller => 'databases', :action => "editDatabaseName", :as => "editName_database"
  match '/databases/updateDatabaseName/:id', :controller => 'databases', :action => "updateDatabaseName", :as => "updateName_database"

  # routes and resources for submissions
  match '/submissions/queue', :controller => 'submissions', :action => "queue", :as => "submission_queue"
  match '/submissions/results', :controller => 'submissions', :action => "results", :as => "submission_results" 
  match '/submissions/:id/cancel', :controller => 'submissions', :action => "cancel", :as => "submission_cancel" 
  # match '/submissions/completed', :controller => 'submissions', :action => "completed", :as => "submission_completed"
  # match '/submissions/failed', :controller => 'submissions', :action => "failed", :as => "submission_failed"
   
  # match '/submissions/start/:id', :controller => 'submissions', :action => "start", :as => "submission_start"
  match '/submissions/:id/download_results', :controller => 'submissions', :action => "download_results", :as => "submission_download_results"
  resources :submissions
  
  root :to => 'submissions#queue'

end
