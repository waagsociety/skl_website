require "sequel"
require "json"   
require "thin"         


class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  configure do                                 
    #
    puts "connecting db"
    $DB = Sequel.connect('sqlite://db.sqlite3')                             
     
    #
    puts "making upload dir"
    FileUtils.mkdir_p 'public/upload'
    
    set :bind, '0.0.0.0'
    set :server, 'thin'  # or thin, mongrel, webrick  
    set :static_cache_control, [:public, max_age: 0]
    enable :cross_origin
    disable :protection
    set :public_folder, 'public'     
    set :sessions, true
    
  end
  
  


end   


