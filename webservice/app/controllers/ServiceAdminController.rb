#minimal cms
class ServiceAdminController < ApplicationController
    
  use Rack::Auth::Basic, "Restricted Area" do |username, password|
      [username, password] == [ADMIN_USER, ADMIN_PASS]  
  end
  
  get "/resource" do
    @entries = []
  
    upload_table = $DB[:upload] #where published == false
    upload_table.all.each { |upload|
      @entries.push({ :id => upload[:id], :description => upload[:description], :link => [request.path,upload[:id].to_s].join("/")})
    }
  
    erb :index
  end 
  
  get "/resource/:id" do |id|
    @entry = {}
     
    #
    record = $DB[:upload].where(:id => id).first
    if record != nil then
      p = getPathForResourceId(record[:resource_id])       
      @entry = record
      if p != nil then
        filename = Pathname.new(p).basename
        @entry[:image_url] = "/admin/image/#{record[:resource_id]}"
        if record[:published] == nil || record[:published] == 0 then
          @entry[:publish_unpublish_url] = ["", "admin", "publish", id].join("/")
          @entry[:publish_unpublish_label] = "publish" 
        else
          @entry[:publish_unpublish_url] = ["", "admin", "unpublish", id].join("/")
          @entry[:publish_unpublish_label] = "unpublish" 
        end
      end
    end

    erb :view
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
  
  post "/publish/:id" do |id|  
     puts "publish #{id}"
     $DB[:upload].where(:id => id).update({:published=>1})
     redirect to('/resource')
  end
  
  post "/unpublish/:id" do |id|
     puts "unpublish #{id}"
     $DB[:upload].where(:id => id).update({:published=>0})
     redirect to('/resource') 
  end

end