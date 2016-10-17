require 'rmagick'     
require 'mkmf'
require 'rexml/document'
require 'pathname'   
require 'tmpdir'             
require 'uri'                                                 
                                            
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

def saveImage path, to, rotate
  
  if rotate != 0 then
    img = Magick::Image::read(path).first
    rotated = img.rotate(rotate)
    rotated.write to
    puts "Written to #{to}"                     
  else                      
    puts "Copied to #{to}"
    FileUtils.cp(path, to) 
  end
  
   
  
end


# def readQRCode id
#   path = getPathForResourceId id
#   result = ""
#    
#   if path != nil then   
#     zbar = find_executable "zbarimg"      
#     if  zbar then
#        xml = `#{zbar} --xml -q #{path}`  
#        doc = REXML::Document.new(xml)
#        qr_codes = doc.elements.to_a("barcodes/source/index/symbol[@type=\"QR-Code\"]/data").map {|data| data.text}
#        
#        if qr_codes.length == 1 then
#          result = qr_codes.first
#        elsif qr_codes.length == 0
#          raise "found no QR code"
#        else
#          raise "found more then one QR code"
#        end
#     else
#       raise "no zbar installed"
#     end
#   else
#     raise "image not found"
#   end                                            
#   
#   return result
# end 

#  
# get an array of all the codes read
#
def readQRCodes path
  result = ""
   
  zbar = find_executable "zbarimg"      
  if zbar == nil then
    raise "zbar not installed"
  end 
  
  xml = `#{zbar} --xml -q #{path}`  
  doc = REXML::Document.new(xml)
  qr_codes = doc.elements.to_a("barcodes/source/index/symbol[@type=\"QR-Code\"]/data").map {|data| data.text}

  return qr_codes
end
                  
# returns degrees cw, qr code should be in upper right corner, and the code found
#
# like : {:code => "http://www.smartkidslab.nl/resultaten/0", :rotation => 90 }
#                      
def analyzeImage path                      
                                
  #find werkblad orientation
  img = Magick::Image::read(path).first   
  w2 = img.columns / 2
  h2 = img.rows / 2
  rotation = 0         
  code = nil
  
  rects = [[w2,h2,w2,h2],[0,h2,w2,h2],[0,0,w2,h2],[w2,0,w2,h2]] #br,bl,tl,tr
  rects.each_with_index do |r,i| 
    crop = img.crop(*r)
    tmp = File.join(Dir.tmpdir(),"q#{i}") 
    puts tmp
    crop.write tmp
    qr_codes = readQRCodes tmp
    FileUtils.rm(tmp)
    if qr_codes.length == 1 then
      uri = URI(qr_codes.first)
      puts "uri #{uri}"
      if uri.host == "www.smartkidslab.nl" then
        rotation = i * 90                
        code = qr_codes.first
        break       
      end
    end  
  end   

  return {:code => code, :rotation => rotation}
end
