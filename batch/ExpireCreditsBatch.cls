global class ExpireCreditsBatch implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date cutOff = Date.today().addYears(-1);
        return Database.getQueryLocator([
            SELECT Id, Status__c, Date_Recorded__c
            FROM Carbon_Credit__c
            WHERE Status__c = 'Active' AND Date_Recorded__c <= :cutOff
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Carbon_Credit__c> scope) {
        for (Carbon_Credit__c c : scope) {
            c.Status__c = 'Inactive';
        }
        if (!scope.isEmpty()) update scope;
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('ExpireCreditsBatch finished at ' + Datetime.now());
    }
}
