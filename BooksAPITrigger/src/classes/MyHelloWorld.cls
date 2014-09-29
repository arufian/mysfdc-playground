public with sharing class MyHelloWorld {

	public static void applyDiscount(Book__c b) {
		Discount_Settings__c settings = Discount_Settings__c.getInstance('local_books');
		Decimal LOCAL_BOOKS_DISC = settings.discount__c;

      	if (b.Price__c <= 100) {
			b.Price__c *= 0.9;
		} else if(b.Price__c > 100) {
			b.Price__c *= (100-LOCAL_BOOKS_DISC)/100;
		}
   	}

   	public static void populateInternetBooks(Book__c book) {
   		YQLBridge.searchGoogleBooks(book.Id);
   	}
}