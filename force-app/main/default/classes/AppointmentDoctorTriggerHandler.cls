public with sharing class AppointmentDoctorTriggerHandler {
    public static void duplicateDoctorAppError(List<Appointment_Doctor__c> adTriggerNew) {

        Set<Id> setOfdoctorIDs = new Set<Id>();
        for (Appointment_Doctor__c eachDoctorID :adTriggerNew) {
            setOfdoctorIDs.add(eachDoctorID.Doctor__c);
        }

        List<Appointment_Doctor__c> listofDoctors = [SELECT Doctor__c, Appointment__c, Doctor__r.Name, Appointment__r.Start_Date_Time__c, Appointment__r.End_Date_Time__c FROM Appointment_Doctor__c WHERE Doctor__c IN :setOfdoctorIDs];
        system.debug('Size of List => ' + listofDoctors.size() + ' ...and List of Doctors => ' + listofDoctors);

        Map<Id, string> mapOfDoctorIdNames = new Map<Id, string>();
        for (Appointment_Doctor__c eachDoctorID :listofDoctors) {
            mapOfDoctorIdNames.put(eachDoctorID.Doctor__c, eachDoctorID.Doctor__r.Name);
        }
        system.debug('size => ' + mapOfDoctorIdNames.size() + ' ...and map => ' + mapOfDoctorIdNames);

        Map<Id, Datetime> mapOfAppointmentStartDates = new Map<Id, Datetime>();
            for (Appointment_Doctor__c AppointmentStartDate : listofDoctors) {
                mapOfAppointmentStartDates.put(AppointmentStartDate.Appointment__c, AppointmentStartDate.Appointment__r.Start_Date_Time__c);
            }
            System.debug(mapOfAppointmentStartDates);

        Map<Id, Datetime> mapOfAppointmentEndDates = new Map<Id, Datetime>();
            for (Appointment_Doctor__c AppointmentEndDate : listofDoctors) {
                mapOfAppointmentEndDates.put(AppointmentEndDate.Appointment__c, AppointmentEndDate.Appointment__r.End_Date_Time__c);
            }
            System.debug(mapOfAppointmentEndDates);

        for (Appointment_Doctor__c eachNameDate : listofDoctors) {
            if (eachNameDate.Doctor__r.Name == mapOfDoctorIdNames.get(eachNameDate.Doctor__r.Id)) {
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