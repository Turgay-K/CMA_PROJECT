public with sharing class AppointmentDoctorTriggerHandler {
    public static void duplicateDoctorAppError(List<Appointment_Doctor__c> adTriggerNew) {

        List<Appointment_Doctor__c> listofAD = [SELECT Appointment__c, Doctor__c FROM Appointment_Doctor__c];

        Set<String> allIDs = new Set<String>();
        for (Appointment_Doctor__c eachAD :listofAD) {
            allIDs.add(eachAD.Appointment__c + '' + eachAD.Doctor__c);
        }

        for (Appointment_Doctor__c comp : adTriggerNew) {
            if (allIDs.contains(comp.Appointment__c + '' + comp.Doctor__c)){
                comp.Doctor__c.addError('Please select another appointment or doctor. Duplicate error!');
            }
        }
    }
}