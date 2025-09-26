public with sharing class CarbonCreditQueries {
    public static List<CarbonCredit__c> getActiveCreditsByProjectIds(Set<Id> projectIds) {
        if (projectIds == null || projectIds.isEmpty()) return new List<CarbonCredit__c>();
        return [
            SELECT Id, Name, CreditAmount__c, Status__c, DateRecorded__c, Project__c
            FROM CarbonCredit__c
            WHERE Project__c IN :projectIds AND Status__c = 'Active'
        ];
    }

    public static List<Partner__c> findPartnerByNameOrEmail(String searchTerm) {
        if (String.isBlank(searchTerm)) return new List<Partner__c>();
        List<List<SObject>> results = [FIND :searchTerm IN ALL FIELDS RETURNING Partner__c(Id, Name, Email__c LIMIT 10)];
        return (results.size() > 0 && results[0] != null) ? (List<Partner__c>) results[0] : new List<Partner__c>();
    }
}

