#############################################################
# Bundler
#############################################################
require 'mongrel_cluster/recipes'
require 'bundler/capistrano'
require 'delayed/recipes'
$:.unshift(File.expand_path("~/.rvm/lib"))
require 'rvm/capistrano'
require "delayed/recipes"
#############################################################
# Application
#############################################################

set :application, "psm"
set :deploy_to, "/opt/#{application}"
set :rails_env, "production"

#############################################################
# Settings
#############################################################

#default_run_options[:pty] = true
set :use_sudo, false

#############################################################
# Servers
#############################################################

set :rvm_ruby_string, "1.9.3"
set :rvm_type, :system
set :user, "ommsa"
set :domain, "proteome.shef.ac.uk"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

server domain, :app, :web
role :db, domain, :primary => true

#############################################################
# Repository
#############################################################

set :scm, :bzr
set :repository, "bzr+ssh://bzr@bzr.genesys-solutions.co.uk/2011-#{application}/trunk"
set :deploy_via, :remote_cache

#############################################################
# Deployment
#############################################################

namespace :deploy do
  task :start do; end

  desc "Restart application in Passenger"
  task :restart do  
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop do; end

 
  desc "Migrate the database"
  task :migrate do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:migrate"
  end

  desc "Seed the database"
  task :seed do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:seed"
  end
 

  desc "Drop database"
  task :dropdb do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:drop"
  end

  desc "Create database"
  task :createdb do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:create"
  end

  desc "setup database"
  task :setup do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:setup"
  end

  desc "reset database"
  task :reset do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:reset"
  end
  desc "Start delayed Job"
  task :dj_start do
    run "cd #{current_path}; RAILS_ENV=production bundle exec ./script/delayed_job start"
  end

  desc "Stop delayed Job"
  task :dj_stop do
    run "cd #{current_path}; RAILS_ENV=production bundle exec ./script/delayed_job stop"
  end

end


desc "tail production log files" 
task :tail_logs, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    trap("INT") { puts 'Interupted'; exit 0; } 
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err
  end
end

desc "Returns last lines of log file. Usage: cap log [-s lines=100] [-s rails_env=production]"
task :log do
    lines     = 100 #configuration.variables[:lines] || 100
      rails_env = 'production' #configuration.variables[:rails_env] || 'production'
        run "tail -n #{lines} #{current_path}/log/#{rails_env}.log" do |ch, stream, out|
    puts out
  end
end


# Steps
#############################################################

#before "deploy:assets:precompile", "bundle:install"
#before "deploy:symlink", "deploy:assets:precompile"
after "deploy:finalize_update" do
  run "ln -s #{File.join(shared_path,'database.yml')} #{File.join(release_path,'config','database.yml')}"
  run "chgrp -R projects #{release_path}"
end

#after "deploy:symlink", "deploy:migrate"
#after "deploy:symlink", "deploy:seed"
#after "deploy:symlink", "deploy:startDJ"
#
#p

after "deploy:restart", "delayed_job:restart"
after "deploy:stop", "delayed_job:stop"
after "deploy:start", "delayed_job:start"

# Clean up old deployments
after 'deploy', 'deploy:cleanup'
