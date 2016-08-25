require 'rmagick'     
require 'zbar'
                   
                                            
def getUploadFolder 
  return File.join("files","upload")
end

def getThumbFolder
  return File.join("files","thumb") 
end

#
def compilePathForResourceId resource_id, extension
   return File.join(getUploadFolder, "#{resource_id}#{extension.downcase}")
end
                                            
#get the path for resource if the file exist
def getPathForResourceId id
  return Dir.glob(File.join(getUploadFolder, "#{id}.*")).first
end 

#get the path for resource if the file exist
def getThumbPathForResourceId id
  return Dir.glob(File.join(getThumbFolder, "#{id}.*")).first
end

def createThumbForResourceId id
   image_path = getPathForResourceId id
   thumb_path = getThumbPathForResourceId id

   if image_path != nil && thumb_path == nil then #do we still need to make thumb
     #compile path
     puts "create thumb"
     filename = Pathname.new(image_path).basename
     dest_path = File.join(getThumbFolder, filename) 

     #make longest side 200 pix
     img = Magick::Image::read(image_path).first
     img.resize_to_fit! 200 
     img.write dest_path
   end
end       

def readQRCode id
  path = getPathForResourceId id                                   
  if path != nil then                   
    file = File.open path
    image = ZBar::Image.from_jpeg file
    file.close 
    p = ZBar::Processor.new 
    results = p.process image 
    if results.length == 1 then
      return results.first.data
    elsif results.length == 0
      raise "found no QR code"
    else
      raise "found more then one QR code"
    end
  end  
  
  return ""
end
