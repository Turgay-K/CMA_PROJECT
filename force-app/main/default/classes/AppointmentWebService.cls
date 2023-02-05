@RestResource (urlMapping='/Appointment/*')
global with sharing class AppointmentWebService {
    @HttpGet
    global static List<appWrapper> appointmentWebServiceGet() {
        List<appWrapper> details = new List<appWrapper>();
        for(Appointment__c evt: [SELECT Id, Appointment_Type__c, Clinic_Manager__r.Name, Department__c, End_Date_Time__c, Frequency__c, Live__c, Location_Verified__c, Location__r.Name, Maximum_number_of_patients__c, Name__c, Patients_Attending__c, Recurring__c, Remaining_Appointment__c, Start_Date_Time__c, Status__c FROM Appointment__c WITH SECURITY_ENFORCED]){
            details.add(new appWrapper(evt));
        }
        return details;
    }
    global class AppWrapper {
        Public String id;
        Public String appointmentType;
        Public String clinicManagerName;
        Public String department;
        Public String frequency;
        Public String locationName;
        Public String name;
        Public String status;
        Public Decimal patientsAttending;
        Public Decimal remainingAppointment;
        Public Decimal maximumNumberOfPatients;
        Public Boolean recurring;
        Public Boolean live;
        Public Boolean locationVerified;
        Public String endDateTime;
        Public String startDateTime;
    public appWrapper(Appointment__c evt) {
        this.Id = evt.Id;
        this.appointmentType = evt.Appointment_Type__c;
        this.clinicManagerName = evt.Clinic_Manager__r.Name;
        this.Department = evt.Department__c;
        this.Frequency = evt.Frequency__c;
        this.locationName = evt.Location__r.Name;
        this.Name = evt.Name__c;
        this.Status = evt.Status__c;
        this.patientsAttending = evt.Patients_Attending__c;
        this.remainingAppointment = evt.Remaining_Appointment__c;
        this.maximumNumberOfPatients = evt.Maximum_number_of_patients__c;
        this.Recurring = evt.Recurring__c;
        this.Live = evt.Live__c;
        this.locationVerified = evt.Location_Verified__c;
        this.endDateTime = evt.End_Date_Time__c?.format('yyyy-mm-dd hh:mm');
        this.startDateTime = evt.Start_Date_Time__c?.format('yyyy-mm-dd hh:mm');
    }
    }
}