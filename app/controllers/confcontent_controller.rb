class ConfcontentController < ApplicationController

require 'xmlrpc/client'

# before_filter :getPageID, :getAttachmentUrls


def index
    base_url = "http://localhost:1990/confluence"

	  @confluence = XMLRPC::Client.new2("#{base_url}/rpc/xmlrpc").proxy("confluence2")
 	  @token = @confluence.login("admin", "admin")
	  getPageID('ds') 
	  # @superlist = @pageIDList.map { |i| "" + i.to_s + "" }.join()
	  getAttachmentUrls(@pageIds)
	  @attachment = @badboy
 	
	  

end
 

def getPageID(space)

   pages = @confluence.getPages(@token, space)
   @pageIds = Array.new  
   # pages.map do |a|
    pages.each do |k|   	
   	 @pageIds << k["id"]
   	 
   end
   

end

# @pageIDList = getPageID('FLIP') 

# @superlist = @pageIDList.map { |i| "" + i.to_s + "" }.join()


def getAttachmentUrls(pagekeys)
	@fixlist = Array.new 
	@badboy = Array.new
    pagekeys.each do |k|
    	    	
    	# key = k.map { |i| "" + i.to_s + "" }.join('')
     	 @fixlist = @confluence.getAttachments(@token, k)
 		 if @fixlist.length > 0
 		 	 
 		 	 @badboy << @fixlist #.first["url"]
 		 else
 		 	 
 		 end
 		 

    end
 

end

def arrayblender

  updatelist = pages

updatelist.each do |ul|
  @badboy.each do |bb|
    if ul['id'] == bb.first['pageId']
      ul['imageurl'] = bb.first['url']
      break
    end

  end
end
  
end

 # @attachment = getAttachmentUrls(@pageIDList)


end
