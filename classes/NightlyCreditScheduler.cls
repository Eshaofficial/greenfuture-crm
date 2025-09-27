global class NightlyCreditScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new ExpireCreditsBatch(), 200);
    }
}