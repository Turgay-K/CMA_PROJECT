@isTest
public with sharing class AppointmentDoctorTriggerTest {
    @TestSetup
    static void makeDataAD(){
        List<Appointment_Doctor__c> listAD = new List<Appointment_Doctor__c>();
        for (Integer i = 0; i < 200; i++) {
            Appointment_Doctor__c ad = new Appointment_Doctor__c();
            ad.Appointment__c = 'Appt-0120'+i;
            ad.Doctor__c = 'Steven McGail' +i;
            listAD.add(ad);
        }
        insert listAD;
        
    }
    }