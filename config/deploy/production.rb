set :application, 'rails-ember-annotate'
set :stage, :production
set :rails_env, 'production'

set :deploy_to, '/var/deploy/rails-ember-annotate'

set :branch, 'master'

role :app, %w{deploy@dexcode.com}
role :web, %w{deploy@dexcode.com}
role :db,  %w{deploy@dexcode.com}
server 'dexcode.com', user: 'deploy', roles: %w{web app}
