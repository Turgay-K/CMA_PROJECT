public class ErrorLog {
    public static void createErrorLog(DateTime logDateTime, string logDetail, string processName) {
        Error_Log__c EL = new Error_Log__c();
        EL.Log_Date_Time__c = logDateTime;
        EL.Log_Details__c = logDetail;
        EL.Process_Name__c = processName;
        insert EL;
    }
}
