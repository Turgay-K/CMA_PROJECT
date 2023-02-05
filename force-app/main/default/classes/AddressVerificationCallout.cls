public with sharing class AddressVerificationCallout {
    
    @future (callout=true)
    public static void AddressVerificationCalloutMethod(Id locId) {
        try {
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            Location__c locInfo = [SELECT Street__c, City__c, State__c, Postal_Code__c FROM Location__c WHERE Id =: locId WITH SECURITY_ENFORCED];
            SmartyAuthorization__c smartApiCredits = SmartyAuthorization__c.getOrgDefaults();

            request.setEndpoint('callout:Smarty/street-address?auth-id=smartApiCredits.auth_id__c&auth-token=smartApiCredits.auth_token__c&candidates=10&street=locInfo.Street__c&city=locInfo.City__c&state=locInfo.State__c&zipcode=locInfo.Postal_Code__c&match=enhanced&license=us-rooftop-geocoding-cloud');
    
            HttpResponse response = new Http().send(request);
    
            Boolean isSuccess = response.getStatusCode() == 200;
            update new Location__c(Id=locId, Verified__c=isSuccess);    
        } catch (Exception exc) {
            ErrorLog.createErrorLog(date.today(), exc.getMessage(), 'AddressVerificationCalloutMethod');
        }
    }
}