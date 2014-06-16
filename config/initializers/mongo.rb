MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "#rails-ember-annotate-#{Rails.env}"
