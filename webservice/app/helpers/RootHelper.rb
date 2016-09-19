module ApplicationHelper
     
  @@cache = {}
                     
  #simple in memory cache, typically store request path and returned response
  def cached path, ttl
                                      
    #return the cached data if we have it fresh enough
    time, data = @@cache[path]
    if time != nil && data != nil then
      if (Time.new.to_i - time) < ttl then
        return data
      end
    end                                               
    
    #callback to get fresh data
    data = yield nil
    if data != nil then
      @@cache[path] = [Time.new.to_i, data]
    end
     
    return data
  end
  
end