# config valid only for current version of Capistrano
lock '3.3.3'

set :application, 'finance'
set :repo_url, 'git@github.com:alleycat-at-git/finance.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
#set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


namespace :server do
  task :stop do
    on roles(:app) do
      execute :sudo, "/etc/init.d/thin stop_single /etc/thin/#{fetch(:application)}.yml"
    end
  end

  task :start do
    on roles(:app) do
      execute :sudo, "/etc/init.d/thin start_single /etc/thin/#{fetch(:application)}.yml"
    end
  end

  task :restart do
    on roles(:app) do
      execute :sudo, "/etc/init.d/thin restart_single /etc/thin/#{fetch(:application)}.yml"
      execute :sudo, '/etc/init.d/nginx restart'
    end
  end

end

namespace :assets do

  task :clone_db do
    #closing dv connection
    invoke 'server:stop'
    on roles(:db) do
      db_dump = '/tmp/db_dump'
      execute "pg_dump finance_production > #{db_dump}"
      execute 'dropdb finance_staging'
      execute 'createdb finance_staging'
      execute "psql finance_staging < #{db_dump}"
      execute "rm #{db_dump}"
    end
    invoke 'server:start'
  end

  task :clone_files do
    on roles(:app) do
      from = '/var/www/finance/shared/public/paperclip'
      to='/var/www/finance_staging/shared/public/paperclip'
      execute "rm -rf #{to}"
      execute "cp -r #{from} #{to}"
    end
    invoke 'assets:symlink'
  end

  task :clone do
    invoke 'assets:clone_db'
    invoke 'assets:clone_files'
  end

  task :symlink do
    on roles(:app) do
      root_parent = File.expand_path('../',fetch(:root))
      execute "rm -f #{root_parent}/current/public/paperclip"
      execute "ln -s #{root_parent}/shared/public/paperclip #{root_parent}/current/public/paperclip"
    end
  end

end



namespace :deploy do

  after :published, 'assets:symlink'
  after :published, 'server:restart'

end
