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
  
  @@geo_factory = RGeo::Cartesian.simple_factory(srid: 4326)
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
  
  post '/form_data' do
                         
    name = params[:name]
    description = params[:description]   
    resource_id = params[:resource_id]   
    lat = params["lat"]
    lon = params["lon"]

    upload_table = $DB[:upload]  
    id = upload_table.insert(params)  
    #  lines = scripts.where(:bid => sid).order(:sid,:weight)
                    # plants = $DB[:plant]
                     #insert what can be inserted
                    # id = plants.insert(filtered)
    return "ok"
  end    
  
  get '/markers' do
    
    features = []    
    
    10.times do 
      lat = rand()
      lon = rand()
      p = @@geo_factory.point(10, 20)  
      props = {"resource_id" => (rand() * 10).to_i.to_s}
      feature = @@entity_factory.feature(p, nil, props)  
      features.push(feature)
    end           
    
    feature_collection = @@entity_factory.feature_collection(features)
    
    content_type "application/vnd.geo+json"
    return RGeo::GeoJSON.encode(feature_collection).to_json
  end
  
end