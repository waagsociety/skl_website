                   
def bla
   puts "bl*******************a"
end                           

def getPathForResourceId id
  uploads_folder = File.absolute_path(File.join(settings.public_folder, "upload"))        
  return Dir.glob(File.join(uploads_folder, "#{id}.*")).first
end