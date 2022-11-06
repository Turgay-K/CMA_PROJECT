public class DoctorTriggerHandler {
    public static void updateDoctorLicense(list<doctor__c> triggerNew) {
        try {
            for (Doctor__c newdoc : triggernew) {
                Boolean b = newdoc.Doctor_License__c.contains('ABC123456789'); 
                }
            }catch (Exception e) {
            ErrorLog.createErrorLog(date.today(), e.getMessage(), 'createDoctor'); 
        }
    }
}