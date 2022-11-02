public with sharing class AppointmentDoctorTriggerHandler {
    public static void duplicateDoctorAppError(List<Appointment_Doctor__c> adTriggerNew, List<Appointment_Doctor__c> adTriggerOld, Map<id, Appointment_Doctor__c> adTriggerNewMap, Map<id, Appointment_Doctor__c> adTriggerOldMap) {
        List<Appointment_Doctor__c> listDate = [SELECT Id, Doctor__r.Name, Appointment__r.End_Date_Time__c, Appointment__r.Start_Date_Time__c FROM Appointment_Doctor__c];
        system.debug('AD list => ' + listDate);
        system.debug('TN list => ' + adTriggerNew);

        system.debug('AD list size => '+ listDate.size());
        system.debug('TN list size => '+ adTriggerNew.size());

        for (Appointment_Doctor__c eachAD : listDate) {
            system.debug('each AD list => ' + eachAD);
            for (Appointment_Doctor__c eachTN : adTriggerNew) {
            system.debug('each TN list => ' + eachTN);
            if (eachAD.Doctor__c == eachTN.Doctor__c && eachAD.Appointment__r.Start_Date_Time__c == eachTN.Appointment__r.Start_Date_Time__c) {
                // system.debug('doctor name => ' + eachAD.Doctor__r.Name);
                // system.debug('doctor name => ' + eachTN.Doctor__r.Name);
                eachTN.Doctor__c.addError('This doctor already has an appointmnet! Please select another doctor');
            }
        }
    }
    }
}

//&& 