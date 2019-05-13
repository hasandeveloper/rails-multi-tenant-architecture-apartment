lock '>=3.4'

set :repo_url,        'git@github.com:hasandeveloper/rails-multi-tenant-architecture-apartment.git'
set :user,            'ubuntu'

set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs,  %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/assets public/uploads)
set :bundle_binstubs, nil

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
     on roles(:app) do
        execute "mkdir #{shared_path}/tmp/sockets -p"
        execute "mkdir #{shared_path}/tmp/pids -p"
     end
  end

  before :start, :make_dirs
end