public class AppointmentsBatchHandler {
    public static void AppointmentsBatchSendEmail() {
    //query the Public Group using Name 
    List<Group> publicGroup = [SELECT Id FROM Group WHERE Name= 'Daily Job Public Group' and Type = 'Regular'];
    //query on the GroupMember sObject to get the User IDs
    List<Id> userIds = new List<Id>(); //make sure this is a List<Id> because Set<Id> is not accepted into setTargetObjectIds(Ids);
    if(publicGroup != null && !publicGroup.isEmpty()){
        for(GroupMember groupMember : [SELECT GroupId, UserOrGroupId FROM GroupMember WHERE GroupId = :publicGroup[0].id]){
            userIds.add(groupMember.UserOrGroupId);
            }
        }
    List<String> mailToAddresses = new List<String>();
    List<User> userEmails = [SELECT Email FROM User WHERE Id IN :userIds];
    for(User u : userEmails) {
        mailToAddresses.add(u.Email);
    }
    EmailTemplate eTemplate = [Select id FROM EmailTemplate WHERE Name = 'Old Appointments Deleted' LIMIT 1];
    if(eTemplate != null){
    Messaging.MassEmailMessage emailGroup = new Messaging.MassEmailMessage();
    //setTargetObjectIds(Ids); is A list of IDs of the contacts, leads, or users to which the email will be sent.
    //The objects must be of the same type (all contacts, all leads, or all users).
    emailGroup.setTargetObjectIds(userIds);
    emailGroup.setSenderDisplayName('System Developer');
    emailGroup.setTemplateId(eTemplate.id);
    emailGroup.setSaveAsActivity(false);    //must be false when sending mail to users OTHERWISE System.EmailException: SendEmail failed. INVALID_SAVE_AS_ACTIVITY_FLAG
    Messaging.sendEmail(new Messaging.MassEmailMessage[]{emailGroup});   
        }
    }
}











/* THIS IS TO SEND A SINGLE EMAIL!
public class AppointmentsBatchHandler {
    public static void AppointmentsBatchSendEmail() {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.toAddresses = new String[] { 'salesforceadmndev@gmail.com' };
        email.subject = 'Old Appointments deleted';
        email.plainTextBody = 'Appointments that are older than 60 days are deleted  today at 3AM';
        Messaging.SingleEmailMessage[] emails = new List<Messaging.SingleEmailMessage> {email};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emails);
    }
}
*/

/* ONE WAY OF IDENTFYING USER WITHIN GROUP
    Public Group can contain Roles, Roles and Subordinates, and other Public Groups as well.
    to get only the users from the Public Group, check if the UserOrGroupId starts with '005'.
    if(String.valueOf(objMember.UserOrGroupId).startsWith('005')){
       System.debug('User Id : ' +objMember.UserOrGroupId);
               }
*/