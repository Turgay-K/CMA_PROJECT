trigger AccountTrigger on Account (before insert) {
    if (trigger.isBefore) {
        AccountTriggerHandler.createAccounts(trigger.new);
    }
}