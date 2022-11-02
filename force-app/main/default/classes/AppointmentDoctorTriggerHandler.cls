public with sharing class AppointmentDoctorTriggerHandler {
    public static void duplicateDoctorAppError(List<Appointment_Doctor__c> adTriggerNew, List<Appointment_Doctor__c> adTriggerOld, Map<id, Appointment_Doctor__c> adTriggerNewMap, Map<id, Appointment_Doctor__c> adTriggerOldMap) {

        //check if Trigger.New is not empty
        system.debug('Trigger.New size => '+ adTriggerNew.size() + ' ... and Trigger.New => ' + adTriggerNew);

        //We only need the IDs of doctors we are trying to make an appointment. Because Appointment_Doctor__c has only two fields (Doctor__c and Appointment__c), we need to use these fields (which are also IDs) to reach the actual doctor names and appointment dates
        //1. Doctor IDs
        Set<Id> setOfdoctorIDs = new Set<Id>();      // this set of doctor IDs will come from Trigger.new
        for (Appointment_Doctor__c eachDoctorID :adTriggerNew) {
            setOfdoctorIDs.add(eachDoctorID.Doctor__c);
        }

        //Now, get a list of doctors using these IDs
        List<Doctor__c> listOfDoctorNames = [SELECT id, Name FROM Doctor__c WHERE Id IN :setOfdoctorIDs];
        //check if this list is not empty)

        //Now, get a map of IDs and Doctors Names
        Map<Id, string> mapOfDoctorNames = new Map<Id, string>();
            for (Doctor__c eachDoctorName : listOfDoctorNames) {
                mapOfDoctorNames.put(eachDoctorName.Id, eachDoctorName.Name);
            }
        system.debug('Map of Doctor Names => '+ mapOfDoctorNames);
        
        //pull all doctors from database using the Doctor IDs
        List<Appointment_Doctor__c> listofDoctors = [SELECT Doctor__c, Appointment__c, Doctor__r.Name, Appointment__r.Start_Date_Time__c, Appointment__r.End_Date_Time__c FROM Appointment_Doctor__c WHERE Doctor__c IN :setOfdoctorIDs];
        //check if SOQL is not empty
        system.debug('Size of List => ' + listofDoctors.size() + ' ...and List of Doctors => ' + listofDoctors);

        //2. Appointment IDs
        Set<Id> setOfAppointmentIDs = new Set<Id>();    // this set of appointment IDs will come from Trigger.new
        for (Appointment_Doctor__c eachAppointmentID : adTriggerNew) {
            setOfAppointmentIDs.add(eachAppointmentID.Appointment__c);
        }

        //List of appointment dates from these IDs.
        List<Appointment__c> listAppointmentDates = [SELECT id, Start_Date_Time__c, End_Date_Time__c FROM Appointment__c WHERE Id In :setOfAppointmentIDs];

        //Map of IDs and Appointments Start Dates
        Map<Id, Datetime> mapOfAppointmentStartDates = new Map<Id, Datetime>();
            for (Appointment__c AppointmentStartDate : listAppointmentDates) {
                mapOfAppointmentStartDates.put(AppointmentStartDate.Id, AppointmentStartDate.Start_Date_Time__c);
            }

        //Map of IDs and Appointments End Dates
        Map<Id, Datetime> mapOfAppointmentEndDates = new Map<Id, Datetime>();
            for (Appointment__c AppointmentEndDate : listAppointmentDates) {
                mapOfAppointmentEndDates.put(AppointmentEndDate.Id, AppointmentEndDate.End_Date_Time__c);
            }

        for (Appointment_Doctor__c eachNameDate : listofDoctors) {
            if (eachNameDate.Doctor__r.Name == mapOfDoctorNames.get(eachNameDate.Doctor__r.Id)) {
                if (eachNameDate.Appointment__r.Start_Date_Time__c == mapOfAppointmentStartDates.get(eachNameDate.Appointment__c)){
                    for (Appointment_Doctor__c eachTN : adTriggerNew) {
                        eachTN.Doctor__c.addError('This doctor already has an appointment! Please select another doctor');
                    }
                }
                else if (eachNameDate.Appointment__r.End_Date_Time__c == mapOfAppointmentEndDates.get(eachNameDate.Appointment__c)){
                        for (Appointment_Doctor__c eachTN : adTriggerNew) {
                            eachTN.Doctor__c.addError('This doctor already has an appointment! Please select another doctor');
                    }
                }
            }
        }
    }
}