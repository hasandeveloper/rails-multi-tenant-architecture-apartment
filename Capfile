
require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rbenv'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.5.0'

require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/puma'
install_plugin Capistrano::Puma
# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }