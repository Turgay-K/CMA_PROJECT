public class AppointmentsBatch implements Database.Batchable<sObject>, Database.stateful{
    public database.QueryLocator start(Database.BatchableContext bc){
        Database.QueryLocator q1 = database.getQueryLocator([SELECT Status__c, Live__c, End_Date_Time__c FROM Appointment__c where status__c = 'Completed' AND End_Date_Time__c < LAST_N_DAYS:60]);
        return q1;
    }
 
    public void execute(Database.BatchableContext bc, List<Appointment__c> scope){
        List<Appointment__c> deleteAppointments = new List<Appointment__c>();
        for (Appointment__c eachApp : scope) {
            if(eachApp.status__c =='completed' && eachApp.End_Date_Time__c <= date.today().adddays(-60) && eachApp.Live__c!=true) {
                deleteAppointments.add(eachApp);
            }   
        }
        if (!deleteAppointments.isEmpty()) {
            delete deleteAppointments;
        }
    }
 
        public void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
 
        message.toAddresses = new String[] { 'salesforceadmndev@gmail.com' };
        message.subject = 'Old Appointments deleted';
        message.plainTextBody = 'Appointments that are older than 60 days are deleted  today at 3AM';
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }  
 }