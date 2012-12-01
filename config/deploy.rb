require "rvm/capistrano"    
set :rvm_ruby_string, 'ruby-1.9.3'        # Or whatever env you want it to run in.
require "bundler/capistrano"
set :bundle_flags, ''

# -*- encoding : utf-8 -*-
default_environment["PATH"] = "/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin"

set :application, "pcc-web"
set :repository,  "git://github.com/tka/pcc-web.git"
set :deploy_to, "/home/apps/#{application}"

set :branch, "master"
set :scm, :git

set :user, "apps"
set :group, "apps"

set :deploy_to, "/home/apps/#{application}"
set :runner, "apps"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1

role :web, "106.186.18.95"                          # Your HTTP server, Apache/etc
role :app, "106.186.18.95"                         # This may be the same as your `Web` server
role :db,  "106.186.18.95"   , :primary => true # This is where Rails migrations will run

set :deploy_env, "production"
set :rails_env, "production"
set :scm_verbose, true
set :use_sudo, false


namespace :deploy do

  task :migrate do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake db:migrate"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :roles => [:web], :except => { :no_release => true } do
    run "if [ -f /tmp/#{application}_unicorn.pid ] ; then kill -s HUP `cat /tmp/#{application}_unicorn.pid`; fi"
  end 

  desc "Start unicorn"
  task :start, :roles => [:web], :except => { :no_release => true } do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec unicorn_rails -c config/unicorn.conf -D"
  end 

  desc "Stop unicorn"
  task :stop, :roles => [:web], :except => { :no_release => true } do
    run "if [ -f /tmp/#{application}_unicorn.pid ] ; then  kill -s QUIT `cat /tmp/#{application}_unicorn.pid`; fi"
  end  

end


namespace :my_tasks do
  task :symlink, :roles => [:web] do
    run "mkdir -p #{deploy_to}/shared/log"
    run "mkdir -p #{deploy_to}/shared/pids"
    
    symlink_hash = {
      "#{shared_path}/config/database.yml"   => "#{release_path}/config/database.yml",
      "#{shared_path}/config/config.yml"   => "#{release_path}/config/config.yml",
      "#{shared_path}/config/action_mailer.yml"   => "#{release_path}/config/action_mailer.yml",
      "#{shared_path}/config/unicorn.conf"   => "#{release_path}/config/unicorn.conf",
      "#{shared_path}/uploads"              => "#{release_path}/public/uploads",
    }

    symlink_hash.each do |source, target|
      run "ln -sf #{source} #{target}"
    end
  end

end



namespace :remote_rake do
  desc "Run a task on remote servers, ex: cap staging rake:invoke task=cache:clear"
  task :invoke do
    run "cd #{deploy_to}/current; RAILS_ENV=#{rails_env} bundle exec rake #{ENV['task']}"
  end
end

after "deploy:finalize_update", "my_tasks:symlink"
after 'deploy:finalize_update', 'deploy:cleanup'

