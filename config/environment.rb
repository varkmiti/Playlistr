require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
require_relative 'omniauth.rb'
require_relative 'routes.rb'

ActiveRecord::Base.logger = nil