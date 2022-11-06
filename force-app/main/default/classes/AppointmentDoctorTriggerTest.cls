@isTest
public with sharing class AppointmentDoctorTriggerTest {
@TestSetup
static void makeDataAD(){
TestDataFactory.appointmentTestData(199);
TestDataFactory.doctorTestData(199);
}
@isTest
public static void junctionOnj() {

List<Appointment__c> listApp = [SELECT id FROM Appointment__c];
List<Doctor__c> listDoc = [SELECT id FROM Doctor__c];

Appointment_Doctor__c ad =new Appointment_Doctor__c();
ad.Appointment__c = listApp[0].id;
ad.Doctor__c = listDoc[0].id;

test.startTest();
insert ad;
test.stopTest();
}
}