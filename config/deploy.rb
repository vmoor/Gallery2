require "bundler/capistrano"
#load 'deploy/assets'

set :rvm_ruby_string, '1.9.3p327'
set :rvm_type, :system

#require "rvm/capistrano"  # Load RVM's capistrano plugin.
set :application, "Gallery2"
set :repository,  "git://github.com/vmoor/Gallery2.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-54-242-35-173.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-54-242-35-173.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-54-242-35-173.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/webapps/#{application}"

set :use_sudo, false
set :keep_releases, 5

set :rails_env, :production

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  namespace :assets do
  	desc "Precompile assets on local machine and upload them to the server."
  	task :precompile, roles: :web, except: {no_release: true} do
  		run_locally "rake assets:precompile"
  		find_servers_for_task(current_task).each do |server|
  			run_locally "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{server.host}:#{shared_path}/"
  		end
  	end
  end
end

after "deploy:update_code", "bundle:install"
 
namespace :bundle do
  desc "Bundle install"
  task :install, :roles => :app do
    run "cd #{current_release} && #{sudo} bundle install"
  end
end

