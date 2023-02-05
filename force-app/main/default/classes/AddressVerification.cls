public with sharing class AddressVerification {
    @InvocableMethod(label='Call Smarty' Description='Will Callout to Smarty for US Address Verification')
    public static void AddressVerificationMethod(List<Id> locationIds){
        AddressVerificationCallout.AddressVerificationCalloutMethod(locationIds[0]);
    }
}