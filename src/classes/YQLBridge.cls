global class YQLBridge {
		
	@future (callout=true)
	public static void searchGoogleBooks(String bookId) {
		Book__c book = [SELECT Name, Id FROM Book__c WHERE Id=:bookId];
		Http http = new Http();
   		HttpRequest req = new HttpRequest();
   		req.setEndpoint('https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20google.books%20WHERE%20q%3D%22'
   			+book.Name+
   			'%22%20AND%20maxResults%3D1&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&format=json');
   		req.setMethod('GET');
   		HttpResponse res = http.send(req);
   		//System.debug('response body : 'res.getBody());
   		JSONParser parser = JSON.createParser(res.getBody());
   		Boolean isInsideVolumeInfo = false;

   		Map<String, Object> root = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
   		Map<String, Object> query = (Map<String, Object>)root.get('query');
   		Map<String, Object> results = (Map<String, Object>)query.get('results');
   		Map<String, Object> jsonItem = (Map<String, Object>)results.get('json');
   		Map<String, Object> items = (Map<String, Object>)jsonItem.get('items');
   		Map<String, Object> volumeInfo = (Map<String, Object>)items.get('volumeInfo');
   		String richStr = 'title :'+volumeInfo.get('title')+'<br >'+
   			'subtitle :'+volumeInfo.get('subtitle')+'<br >'+
   			'author :'+volumeInfo.get('authors')+'<br >'+
   			'thumbnail : <img src="'+((Map<String, Object>)volumeInfo.get('imageLinks')).get('thumbnail')+'" />';
   		book.Web_Results__c = richStr;
   		//System.debug('Web_Results__c: '+book.Web_Results__c);
   		update book;
	}

}