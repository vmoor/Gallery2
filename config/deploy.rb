
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"
set :application, "Gallery2"
set :repository,  "git://github.com/vmoor/Gallery2.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-50-16-151-52.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-50-16-151-52.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-50-16-151-52.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "ubuntu"
set :deploy_to, "/home/ubuntu/apps/#{application}"

set :use_sudo, false
set :keep_releases, 5
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
end