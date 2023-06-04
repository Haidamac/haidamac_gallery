# config valid for current version and patch releases of Capistrano
lock "~> 3.17.3"

set :application, "haidamac_gallery"
set :repo_url, "git@github.com:Haidamac/haidamac_gallery.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, 'deployer'
set :puma_user, fetch(:user)
set :rvm_ruby_version, '3.2.2'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/master.key', 'config/puma.rb', 'config/credentials.production.yml')
set :linked_dirs,  fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/images',
                                                'storage')

set :config_example_suffix, '.example'
set :config_files, %w[config/database.yml config/credentials.production.yml]
set :nginx_use_ssl, false
set :env_file, '.env.production.local'

namespace :deploy do
    before 'check:linked_files', 'set:master_key'
    before 'check:linked_files', 'config:push'
    before 'check:linked_files', 'puma:jungle:setup'
end

after 'deploy:finished', 'nginx:restart'
after 'deploy:finished', 'puma:restart'

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
