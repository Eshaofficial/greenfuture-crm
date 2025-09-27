public with sharing class SustainabilityProjectTriggerHandler {

    public static void afterUpdate(List<SustainabilityProject__c> newProjects, Map<Id, SustainabilityProject__c> oldMap) {
        List<SustainabilityProject__c> completedProjects = new List<SustainabilityProject__c>();
        
        for (SustainabilityProject__c p : newProjects) {
            SustainabilityProject__c oldP = oldMap.get(p.Id);
            if (p.Status__c == 'Completed' && oldP.Status__c != 'Completed') {
                completedProjects.add(p);
            }
        }

        if (!completedProjects.isEmpty()) {
            CarbonCreditManager.createCreditsForCompletedProjects(completedProjects);
        }
    }
}

