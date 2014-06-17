# config valid only for Capistrano 3.1
lock '3.1.0'

set :rvm_ruby_version, '2.0.0'
set :repo_url, 'git@github.com:aprimadi/rails-ember-annotate.git'

set :user, "deploy"
set :use_sudo, false

set :deploy_via, :remote_cache

set :linked_files, %w{}
set :linked_dirs, %w{log tmp/cache tmp/sockets tmp/pids public/assets public/uploads}

set :ssh_options, { forward_agent: true, auth_methods: %w(publickey) }

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :publishing, :restart
end
