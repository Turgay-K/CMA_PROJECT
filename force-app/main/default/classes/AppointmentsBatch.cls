public class AppointmentsBatch implements Database.Batchable<sObject>{
    public database.QueryLocator start(Database.BatchableContext bc){
        Database.QueryLocator q1 = database.getQueryLocator([SELECT Status__c, End_Date_Time__c FROM Appointment__c where status__c = 'Completed' AND End_Date_Time__c < LAST_N_DAYS:60]);
        return q1;
    }
    public void execute(Database.BatchableContext bc, List<Appointment__c> scope){
        List<Appointment__c> deleteAppointments = new List<Appointment__c>();
        for (Appointment__c eachApp : scope) {
            if(eachApp.status__c =='completed' && eachApp.End_Date_Time__c <= date.today().adddays(-60)) {
                deleteAppointments.add(eachApp);
            }   
        }
        if (!deleteAppointments.isEmpty()) {
            delete deleteAppointments;
        }
    }
        public void finish(Database.BatchableContext bc){
            AppointmentsBatchHandler.AppointmentsBatchSendEmail();
    }  
 }
















 

 /*
 List<Appointment__c> dateList =[SELECT Id, Start_Date_Time__c, End_Date_Time__c FROM Appointment__c ORDER BY Id ASC LIMIT 10];
system.debug(dateList);
for(Appointment__c eachDL : dateList){
    system.debug(eachDL);
    system.debug(eachDL.Start_Date_Time__c);
    eachDL.Start_Date_Time__c = eachDL.Start_Date_Time__c.addDays(-60);
    system.debug(eachDL.Start_Date_Time__c);
    system.debug(eachDL.End_Date_Time__c);
    eachDL.End_Date_Time__c = eachDL.End_Date_Time__c.addDays(-60);
     system.debug(eachDL.End_Date_Time__c);
}
update dateList;
*/