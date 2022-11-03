trigger AppointmentDoctorTrigger on Appointment_Doctor__c(before insert, before update){
    if (Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate){
            AppointmentDoctorTriggerHandler.duplicateDoctorAppError(Trigger.New);
    }
    }
}