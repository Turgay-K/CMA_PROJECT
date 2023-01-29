public with sharing class AccountTriggerHandler {
    public static void createAccounts(List<Account> triggerNew) {
        try {
            system.debug(triggerNew);
            for (Account eachAcc : triggerNew) {
            eachAcc.Name = 'Name from Trigger BEFORE Exception';
            String s;
            Boolean b = s.contains(eachAcc.Name); // Causes a null exception
            //it would throw an error but still save the record. This error will not prevent record saving!
            eachAcc.Name = 'Name from Trigger AFTER Exception';
            }
            
        } catch(Exception e) {
            ErrorLog.createErrorLog(date.today(), e.getMessage(), 'createAccount');    
        }
    }
}
