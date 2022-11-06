public with sharing class AccountTriggerHandler {
    public static void createAccounts(List<Account> triggerNew) {
        try {
            String s;
            Boolean b = s.contains('abc'); // Causes a    
        } catch(Exception e) {
            ErrorLog.createErrorLog(date.today(), e.getMessage(), 'createAccount');    
        }
    }
}
