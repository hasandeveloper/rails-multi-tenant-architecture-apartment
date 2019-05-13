# frozen_string_literal: true
server '13.127.131.221', user: 'ubuntu', roles: %w(web app db)

# For Production Use a new server and use that servers IP Address

# Don't change these unless you know what you're doing
set :application,     'project_management'
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/production/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa)
set :puma_preload_app, true
set :puma_threads,    [0, 16]
set :puma_workers,    1
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord
set :branch, proc { `git rev-parse --abbrev-ref master`.chomp }
set :keep_releases, 3
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
     on roles(:app) do
        unless `git rev-parse HEAD` == `git rev-parse origin/master`
           puts 'WARNING: HEAD is not the same as origin/master'
           puts 'Run `git push` to sync changes.'
           exit
        end
     end
  end

  desc 'Initial Deploy'
  task :initial do
     on roles(:app) do
        before 'deploy:restart', 'puma:start'
        invoke 'deploy'
     end
  end

  desc 'Restart application'
  task :restart do
     on roles(:app), in: :sequence, wait: 5 do
        invoke 'puma:restart'
     end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end