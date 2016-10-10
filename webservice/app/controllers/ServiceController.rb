require 'rgeo/geo_json' 
require 'securerandom'
require 'pathname'  
require 'mime/types'  
require "uri"
                          
# CREATE TABLE upload (
#   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
#   name TEXT, 
#   description TEXT,
#   lat FLOAT,
#   lon FLOAT,  
#   resource_type INT,
#   resource_id TEXT,
#   published INTEGER,
#   sqltime TIMESTAMP DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) NOT NULL
# );

class ServiceController < ApplicationController   
  
  @@geo_factory = RGeo::Geographic.spherical_factory()
  @@entity_factory = RGeo::GeoJSON::EntityFactory.instance
  
  post '/file_upload' do
    
    response = { :result => {:resource_id => "", :qr_code => ""}, :errors => []}
    
    begin
    
      #params        
      name = params[:file][:name]
      filename = params[:file][:filename]   
      tmp_file = params[:file][:tempfile].path rescue nil  
    
      #copy to public path  
      puts "params : #{params}"          
      
      puts "file : #{params[:file]}"          
      picture_data = analyzeImage(tmp_file) 
      
      #rotate the image if needed       
      host = URI.parse((picture_data[:code] rescue "")).host rescue nil
      
      #generate resource id
      resource_id = SecureRandom.hex(10) 
      response[:result][:resource_id] = resource_id
        
      #write the image to the uploads folder, giving it an generated id
      dest_file = compilePathForResourceId resource_id, File.extname(tmp_file)                
      saveImage tmp_file, dest_file, 360 - picture_data[:rotation]
      
      #result is found qr code
      response[:result][:qr_code] = picture_data[:code]  
      
      #
      if host != "www.smartkidslab.nl" then
        response[:errors].push "QR code not found"
      end
    
    rescue Exception => e  
      puts "errors #{e}"
      response[:errors].push e.to_s
    end
    
    #return resource id
    return response.to_json 
  end    
  
  post '/form' do
    
    #                     
    name = params[:name]
    description = params[:description]   
    resource_id = params[:resource_id]
    qr_code = params[:qr_code]   
    lat = params["lat"]
    lon = params["lon"]
    
    
    begin       
      if getPathForResourceId resource_id == nil then
         throw "resource not found"
      end   
      
      #make a record for the db with the field in this post that are cols in the db
      upload_table = $DB[:upload]      
      cols = {}
      params.each do |key,val| 
        if upload_table.columns.include?(key.to_sym) then    
          cols[key.to_sym] = val
        end
      end
         
      #publish if we have valid qr
      cols[:published] = qr_code.empty? ? 0 : 1
      id = upload_table.insert(cols)  
    rescue Exception => e
      halt 400, "#{e}"
    end
    
    return "ok"
  end    
  
  get '/markers' do
    
    features = []  
               
    #make features
    upload_table = $DB[:upload].where(:published => 1)  
    upload_table.all.each { |upload|
      p = @@geo_factory.point(upload[:lon], upload[:lat]) 
      props = {"resource_id" => upload[:resource_id], "icon" => upload[:resource_type], "description" => upload[:description]}
      feature = @@entity_factory.feature(p, nil, props)  
      features.push(feature)
    }     
    
    #put in collection collection
    feature_collection = @@entity_factory.feature_collection(features)
                       
    #return as json
    content_type "application/vnd.geo+json"
    return RGeo::GeoJSON.encode(feature_collection).to_json
  end     
  
  get '/resource/:id' do |id| 
      
    #find image file
    file = getPathForResourceId(id)
    
    #find table record
    upload_table = $DB[:upload]
    record = upload_table.where(:resource_id => id).first  
          
    #create result
    result = {}
    if file != nil && record then
    
      #find table record 
      image_uri = nil
      thumb_uri = nil               
      
      case request.scheme    
        when "https" 
           image_uri = URI::HTTPS.build({:host => request.host, :port=> request.port, :path => "/api/image/#{id}"})  
           thumb_uri = URI::HTTPS.build({:host => request.host, :port=> request.port, :path => "/api/thumb/#{id}"})
        else
           image_uri = URI::HTTP.build({:host => request.host, :port=> request.port, :path => "/api/image/#{id}"})  
           thumb_uri = URI::HTTP.build({:host => request.host, :port=> request.port, :path => "/api/thumb/#{id}"})
      end  
        
      #make result
      result[:resource_id] = id
      result[:image_url] = image_uri
      result[:thumb_url] = thumb_uri
      result[:description] = record[:description]
      result[:name] = record[:name]
      result[:lat] = record[:lat]
      result[:lon] = record[:lon]
    end             
    
    return result.to_json                      
  end
  
  get '/image/:id' do |id|
     
    #create if needed 
    path = getPathForResourceId id

    if path != nil then
      mime = MIME::Types.type_for(path).first
      mime = "image/jpeg" if mime == nil
      content_type mime
      send_file path, :type => mime       
    end
    
    halt 404, "image not found"
  end 
  
  get '/thumb/:id' do |id|
     
    #create if needed 
    path = getThumbPathForResourceId id
    if path == nil 
      createThumbForResourceId id      
      path = getThumbPathForResourceId id
    end                                  
                     
    #serve if possible
    if path != nil then
      mime = MIME::Types.type_for(path).first
      mime = "image/jpeg" if mime == nil
      content_type mime
      send_file path, :type => mime       
    end
    
    halt 404, "image not found"
  end 
  
  
end