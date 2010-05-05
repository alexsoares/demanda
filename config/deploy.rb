set :application, "ribeirosoares.com"
set :repository,  "git://github.com/alexsoares/demanda.git"

set :user, "railsapps"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

server application, :app, :web, :db, :primary => true

after "deploy:update_code", "deploy:custom_symlinks"
after "deploy:symlink", "deploy:update_crontab"

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   
   task :custom_symlinks do
     run "rm -rf #{release_path}/config/database.yml"
     run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
   end
    desc "Update the crontab file"
    task :update_crontab, :roles => :db do
#    task :update_crontab do
      run "cd #{release_path} && whenever --update-crontab #{application}"
    end

 end
