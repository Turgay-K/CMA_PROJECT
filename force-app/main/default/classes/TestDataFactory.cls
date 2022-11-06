public with sharing class TestDataFactory {
    public static List<Appointment__c> appointmentTestData(integer n) {
        List<Appointment__c> listAppointment = new List<Appointment__c>();
        for (Integer i = 0; i < n; i++) {
            Appointment__c app1 = new Appointment__c();
            app1.Name__c ='Cardiology';
            app1.Clinic_Manager__c = 'a01Dn000001jLd7IAE';
            app1.Start_Date_Time__c = Datetime.now().addDays(3);
            app1.End_Date_Time__c = Datetime.now().addDays(5);
            app1.Maximum_number_of_patients__c = 12;
            listAppointment.add(app1);
        }
        insert listAppointment;
        return listAppointment;
    }
        public static List<Doctor__c> doctorTestData(integer n){
        List<Doctor__c> listDoctor = new List<Doctor__c>();
        for (Integer i = 0; i < n; i++) {
            Doctor__c doc1 = new Doctor__c();
            doc1.Name ='Doctor Ali'+i;
            doc1.Phone__c = '12345678900'+i;
            doc1.Email__c = i+'email@email.com';
            listDoctor.add(doc1);
        }
        insert listDoctor;
        return listDoctor; 
    }
}