trigger DoctorTrigger on Doctor__c (before insert) {
    if (trigger.isBefore && trigger.isInsert) {
        DoctorTriggerHandler.updateDoctorLicense(trigger.new);
    }
}