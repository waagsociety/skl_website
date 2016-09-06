# config.ru
require 'sinatra/base' 
require_relative 'config.rb'

# pull in the helpers and controllers, order is important! 
Dir.glob('./app/helpers/*.rb').sort.each { |file| require file }
Dir.glob('./app/controllers/*.rb').sort.each { |file| require file }

# map the controllers to routes
map('/') { run RootController }
map('/api') { run ServiceController }
map('/admin') { run ServiceAdminController }

