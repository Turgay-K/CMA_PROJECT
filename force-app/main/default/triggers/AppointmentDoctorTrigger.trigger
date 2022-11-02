trigger AppointmentDoctorTrigger on Appointment_Doctor__c(before insert, before update, after insert, after update){
    if (Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate){
            AppointmentDoctorTriggerHandler.duplicateDoctorAppError(Trigger.New, Trigger.Old, Trigger.NewMap, Trigger.OldMap);
    }
    }
}