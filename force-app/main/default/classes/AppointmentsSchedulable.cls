public class AppointmentsSchedulable implements Schedulable{
    public void execute(SchedulableContext sc){
        AppointmentsBatch ab = new AppointmentsBatch();
        database.executeBatch(ab);
    }
}