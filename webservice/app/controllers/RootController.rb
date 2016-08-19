require 'rgeo/geo_json' 
require 'securerandom'
                          
# CREATE TABLE upload (
#   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
#   name TEXT, 
#   description TEXT,
#   lat FLOAT,
#   lon FLOAT,  
#   resource_type INT,
#   resource_id TEXT,
#   sqltime TIMESTAMP DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) NOT NULL
# );

class RootController < ApplicationController   
  
  @@geo_factory = RGeo::Geographic.spherical_factory()
  @@entity_factory = RGeo::GeoJSON::EntityFactory.instance
  
  # get '/*' do
  #                           
  #     if session[:key] == nil then
  #        puts "no session"
  #        session[:key] = "blabla"
  #     else
  #        puts " session #{session[:key]}"
  #     
  #     end                       
  #     
  #     return "bla"
  #   end      
  
  #example : curl -i -F tags=13 -F folder=3/13/ -F filedata=@0.jpg http://127.0.0.1:3000/cloudinary/upload
  post '/file_upload' do
    
    #params        
    name = params[:file][:name]
    filename = params[:file][:filename]   
    tmp_file = params[:file][:tempfile]  
    
    #generate resource id
    resource_id = SecureRandom.hex(10) 
                         
    #copy to public path
    dest_file = File.absolute_path(File.join(settings.public_folder, "upload", "#{resource_id}#{File.extname(tmp_file)}"))                
    r = FileUtils.cp(tmp_file, dest_file)                      
                       
    #return resource id
    return resource_id 
  end    
  
  post '/form' do
    
    #                     
    name = params[:name]
    description = params[:description]   
    resource_id = params[:resource_id]   
    lat = params["lat"]
    lon = params["lon"]
    
    #
    begin       
      if resource_id.empty? then  #TODO: check for existence
         puts "bla"
         throw "resource not found"
      end
      
      upload_table = $DB[:upload]  
      id = upload_table.insert(params)  
    rescue Exception => e
      halt 400, "#{e}"
    end
    
    return "ok"
  end    
  
  get '/markers' do
    
    features = []  
               
    #make features
    upload_table = $DB[:upload]  
    upload_table.all.each { |upload|
      p = @@geo_factory.point(upload[:lon], upload[:lat]) 
      props = {"resource_id" => upload[:resource_id], "icon" => "star", "description" => upload[:description]}
      feature = @@entity_factory.feature(p, nil, props)  
      features.push(feature)
    }     
    
    #put in collection collection
    feature_collection = @@entity_factory.feature_collection(features)
                       
    #return as json
    content_type "application/vnd.geo+json"
    return RGeo::GeoJSON.encode(feature_collection).to_json
  end
  
end