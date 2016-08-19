# config.ru
require 'sinatra/base'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers}/*.rb').each { |file| require file }

# map the controllers to routes
map('/') { run RootController }
map('/api') { run ServiceController }
map('/admin') { run ServiceAdminController }

