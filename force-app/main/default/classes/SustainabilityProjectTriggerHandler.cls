public with sharing class SustainabilityProjectTriggerHandler {
    private static Boolean executed = false;

    public static void afterUpdate(List<SustainabilityProject__c> newList, Map<Id, SustainabilityProject__c> oldMap) {
        if (executed) return;
        executed = true;

        List<SustainabilityProject__c> completedProjects = new List<SustainabilityProject__c>();
        for (SustainabilityProject__c p : newList) {
            SustainabilityProject__c oldP = oldMap.get(p.Id);
            if (oldP != null && oldP.Status__c != 'Completed' && p.Status__c == 'Completed') {
                completedProjects.add(p);
            }
        }

        if (!completedProjects.isEmpty()) {
            CarbonCreditManager.createCreditsForCompletedProjects(completedProjects);

            // Enqueue notifications/tasks for reviewing created credits (non-blocking)
            List<Id> projectIds = new List<Id>();
            for (SustainabilityProject__c p : completedProjects) projectIds.add(p.Id);
            System.enqueueJob(new NotifyQueueable(projectIds));
        }
    }
}
