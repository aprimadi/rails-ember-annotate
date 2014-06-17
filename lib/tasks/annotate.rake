namespace :annotate do
  desc "annotate models"
  task :models => :environment do
    exec "annotate --e tests,fixtures -p before -i"
  end
end
