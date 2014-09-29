trigger PopulateWebResults on Book__c (before insert, before update) {
	Book__c[] books = Trigger.new;
	for (Book__c b :books){
		BookController.applyDiscount(b);
		if(b.Web_Results__c == NULL || b.Web_Results__c.trim().equals('') 
			||  b.Web_Results__c.trim().equals('<br>')) {
			BookController.populateInternetBooks(b);
		}
	}
}
