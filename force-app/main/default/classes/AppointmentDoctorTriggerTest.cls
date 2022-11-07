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

List<Appointment_Doctor__c> adFullList =new List<Appointment_Doctor__c>();
for (Integer i = 0; i < listApp.size(); i++) {
    Appointment_Doctor__c ad =new Appointment_Doctor__c();
    ad.Appointment__c = listApp[i].id;
    ad.Doctor__c = listDoc[i].id;
    adFullList.add(ad);        
}
system.debug(adFullList);

test.startTest();
insert adFullList;
test.stopTest();

system.assert(!adFullList.isEmpty());
system.assertEquals(199, adFullList.size());
}
}