public with sharing class AppointmentDoctorTriggerHandler {
    public static void duplicateDoctorAppError(List<Appointment_Doctor__c> adTriggerNew, List<Appointment_Doctor__c> adTriggerOld, Map<id, Appointment_Doctor__c> adTriggerNewMap, Map<id, Appointment_Doctor__c> adTriggerOldMap) {
        List<Appointment_Doctor__c> listNameDate = [SELECT Id, Appointment__c, Doctor__c, Doctor__r.Name, Appointment__r.Start_Date_Time__c, Appointment__r.End_Date_Time__c FROM Appointment_Doctor__c];
        //check if SOQL is a list (not empty)
        system.debug('AD list size => '+ listNameDate.size());

        //check if Trigger.New is a list (not empty)
        system.debug('TN list size => '+ adTriggerNew.size() + ' ... and TN List => ' + adTriggerNew);

        //Because Appointment_Doctor__c has only two fields (Doctor__c and Appointment__c), we need to use these fields (which are also IDs) to reach the actual doctor names and appointment dates
        //1. Doctor IDs
        Set<Id> setOfdoctorIDs = new Set<Id>();      // this set of doctor IDs will come from Trigger.new
        for (Appointment_Doctor__c eachDoctorID : adTriggerNew) {
            setOfdoctorIDs.add(eachDoctorID.Doctor__c);
        }
        System.debug(setOfdoctorIDs);

        //List of doctor names from these IDs.
        List<Doctor__c> listOfDoctorNames = [SELECT id, Name FROM Doctor__c WHERE Id In :setOfdoctorIDs];
        system.debug(listOfDoctorNames);

        //Map of IDs and Doctors Names
        Map<Id, string> mapOfDoctorNames = new Map<Id, string>();
        if (!listOfDoctorNames.isEmpty()) {
            for (Doctor__c eachDoctorName : listOfDoctorNames) {
                mapOfDoctorNames.put(eachDoctorName.Id, eachDoctorName.Name);
            }
        }
        system.debug(mapOfDoctorNames);


        //2. Appointment IDs
        Set<Id> setOfAppointmentIDs = new Set<Id>();    // this set of appointment IDs will come from Trigger.new
        for (Appointment_Doctor__c eachAppointmentID : adTriggerNew) {
            setOfAppointmentIDs.add(eachAppointmentID.Appointment__c);
        }
        System.debug(setOfAppointmentIDs);

        //List of appointment dates from these IDs.
        List<Appointment__c> listAppointmentDates = [SELECT id, Start_Date_Time__c, End_Date_Time__c FROM Appointment__c WHERE Id In :setOfAppointmentIDs];
        system.debug(listAppointmentDates);

        //Map of IDs and Appointments Start Dates
        Map<Id, Datetime> mapOfAppointmentStartDates = new Map<Id, Datetime>();
        if (!listAppointmentDates.isEmpty()) {
            for (Appointment__c AppointmentStartDate : listAppointmentDates) {
                mapOfAppointmentStartDates.put(AppointmentStartDate.Id, AppointmentStartDate.Start_Date_Time__c);
            }
        }
        system.debug(mapOfAppointmentStartDates);

        //Map of IDs and Appointments End Dates
        Map<Id, Datetime> mapOfAppointmentEndDates = new Map<Id, Datetime>();
        if (!listAppointmentDates.isEmpty()) {
            for (Appointment__c AppointmentEndDate : listAppointmentDates) {
                mapOfAppointmentEndDates.put(AppointmentEndDate.Id, AppointmentEndDate.End_Date_Time__c);
            }
        }
        system.debug(mapOfAppointmentEndDates);

        for (Appointment_Doctor__c eachNameDate : listNameDate) {
           if (eachNameDate.Doctor__r.Name == mapOfDoctorNames.get(eachNameDate.Doctor__r.Id)) {
            for (Appointment_Doctor__c eachTN : adTriggerNew) {
                eachTN.Doctor__c.addError('This doctor already has an appointment! Please select another doctor');
                }

                /*
                if (eachNameDate.Appointment__r.Start_Date_Time__c <= mapOfAppointmentStartDates.get(eachNameDate.Appointment__c && eachNameDate.Appointment__r.End_Date_Time__c <= mapOfAppointmentEndDates.get(eachNameDate.Appointment__c))){
                    for (Appointment_Doctor__c eachTN : adTriggerNew) {
                eachTN.Doctor__c.addError('This doctor already has an appointment! Please select another doctor');
                }
                }
                */

                /*
                if(eachNameDate.Appointment__r.Start_Date_Time__c == mapOfAppointmentStartDates.get(eachNameDate.Appointment__c) || eachNameDate.Appointment__r.End_Date_Time__c == mapOfAppointmentEndDates.get(eachNameDate.Appointment__c)){
                     for (Appointment_Doctor__c eachTN : adTriggerNew) {
                eachTN.Doctor__c.addError('This doctor already has an appointment! Please select another doctor');
                }
                }
                */
        }
    }
}
}