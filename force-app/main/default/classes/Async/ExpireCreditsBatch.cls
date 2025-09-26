global class ExpireCreditsBatch implements Database.Batchable<sObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        Date cutOff = Date.today().addYears(-1);
        String q = 'SELECT Id, Status__c, Date_Recorded__c FROM CarbonCredit__c WHERE Status__c = \'Active\' AND Date_Recorded__c <= ' + cutOff.format();
        return Database.getQueryLocator(q);
    }

    global void execute(Database.BatchableContext BC, List<CarbonCredit__c> scope) {
        List<CarbonCredit__c> updates = new List<CarbonCredit__c>();
        for (CarbonCredit__c c : scope) {
            c.Status__c = 'Inactive';
            updates.add(c);
        }
        if (!updates.isEmpty()) update updates;
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('ExpireCreditsBatch finished at ' + Datetime.now());
    }
}
