class ConfcontentController < ApplicationController

require 'xmlrpc/client'

# before_filter :getPageID, :getAttachmentUrls



def index

	  @confluence = XMLRPC::Client.new2("http://localhost:8080/rpc/xmlrpc").proxy("confluence2")
 	  @token = @confluence.login("admin", "admin")
	  @pageIDList = getPageID('FLIP') 
	  @superlist = @pageIDList.map { |i| "" + i.to_s + "" }.join()
	  getAttachmentUrls(@pageIDList)
	  @attachment = @badboy	
 	
	  

end
 

def getPageID(space)

   pages = @confluence.getPages(@token, space)
   @pageIds = Array.new  
   pages.map do |a|
     @pageIds = Array.new  	
   	 @pageIds << a["id"]
   	 
   end
   

end

# @pageIDList = getPageID('FLIP') 

# @superlist = @pageIDList.map { |i| "" + i.to_s + "" }.join()


def getAttachmentUrls(pagekeys)
	@attachmentList = Array.new 
	@badboy = Array.new
    pagekeys.each do |k|
    	    	
    	key = k.map { |i| "" + i.to_s + "" }.join('')
     	 fixlist = @confluence.getAttachments(@token, key)
 		 if fixlist.length > 0
 		 	 
 		 	 @badboy << fixlist.first["url"]
 		 else
 		 	 
 		 end
 		 

    end
 

end

 # @attachment = getAttachmentUrls(@pageIDList)






end
