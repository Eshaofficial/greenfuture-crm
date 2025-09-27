public with sharing class CarbonCreditManager {

    /**
     * Bulk create Carbon_Credit__c records for completed Sustainability Projects.
     * @param projects List of SustainabilityProject__c
     */
    public static void createCreditsForCompletedProjects(List<SustainabilityProject__c> projects) {
        if (projects == null || projects.isEmpty()) return;

        List<Carbon_Credit__c> creditsToInsert = new List<Carbon_Credit__c>();

        for (SustainabilityProject__c p : projects) {
            if (p.Status__c == 'Completed') {
                Carbon_Credit__c credit = new Carbon_Credit__c();
                credit.Carbon_Credit_Name__c = p.Name + ' Credit';

                // Credit amount logic
                Decimal amount = 100;
                if (p.ProjectBudget__c != null && p.ProjectBudget__c > 0) {
                    amount = Math.max(1, (p.ProjectBudget__c / 1000).setScale(0));
                }
                credit.Credit_Amount__c = amount;

                credit.Type__c = 'Earned';
                credit.Date_Recorded__c = Date.today();
                credit.Project__c = p.Id;
                credit.Status__c = 'Active';
                credit.Source__c = 'Internal';

                creditsToInsert.add(credit);
            }
        }

        if (!creditsToInsert.isEmpty()) {
            try {
                insert creditsToInsert;
            } catch (DmlException ex) {
                System.debug('Error inserting Carbon Credits: ' + ex.getMessage());
            }
        }
    }
}
