public with sharing class CarbonCreditQueries {

    /**
     * Get all active Carbon_Credit__c records for a given project
     */
    public static List<Carbon_Credit__c> getCreditsForProject(Id projectId) {
        if (projectId == null) return new List<Carbon_Credit__c>();
        return [SELECT Id, Name, Credit_Amount__c, Type__c, Date_Recorded__c, Status__c
                FROM Carbon_Credit__c
                WHERE Project__c = :projectId AND Status__c = 'Active'];
    }
}

