require 'rmagick'
                   
def bla
   puts "bl*******************a"
end                           
                                            
#
def compilePathForResourceId resource_id, extension
   return File.join(settings.public_folder, "upload", "#{resource_id}#{extension.downcase}")
end

                                            
#get the path for resource if the file exist
def getPathForResourceId id
  uploads_folder = File.absolute_path(File.join(settings.public_folder, "upload"))        
  return Dir.glob(File.join(uploads_folder, "#{id}.*")).first
end 

#get the path for resource if the file exist
def getThumbPathForResourceId id
  thumbs_folder = File.absolute_path(File.join(settings.public_folder, "thumb"))        
  return Dir.glob(File.join(thumbs_folder, "#{id}.*")).first
end

def createThumbForResourceId id
   image_path = getPathForResourceId id
   thumb_path = getThumbPathForResourceId id

   if image_path != nil && thumb_path == nil then #do we still need to make thumb
     #compile path
     puts "create thumb"
     filename = Pathname.new(image_path).basename
     dest_path = File.join(settings.public_folder, "thumb", filename) 

     #make longest side 200 pix
     img = Magick::Image::read(image_path).first
     img.resize_to_fit! 200 
     img.write dest_path
   end
end