public with sharing class CarbonCreditManager {
    /**
     * Bulk create CarbonCredit__c records for completed projects.
     * - projects must be bulk-friendly (pass list)
     */
    public static void createCreditsForCompletedProjects(List<SustainabilityProject__c> projects) {
        if (projects == null || projects.isEmpty()) return;

        List<CarbonCredit__c> creditsToInsert = new List<CarbonCredit__c>();

        for (SustainabilityProject__c p : projects) {
            if (p.Status__c == 'Completed') {
                CarbonCredit__c c = new CarbonCredit__c();
                c.Name = p.Name + ' Credit';

                // Default logic: if budget present, estimate credits, otherwise default 100
                Decimal creditVal = 100;
                if (p.ProjectBudget__c != null && p.ProjectBudget__c > 0) {
                    creditVal = Math.max(1, (p.ProjectBudget__c / 1000).setScale(0));
                }
                c.CreditAmount__c = creditVal;

                c.Type__c = 'Earned';
                c.DateRecorded__c = Date.today();
                c.Project__c = p.Id;
                c.Status__c = 'Active';
                c.Source__c = 'Internal';

                creditsToInsert.add(c);
            }
        }

        if (!creditsToInsert.isEmpty()) {
            try {
                insert creditsToInsert;
            } catch (DmlException ex) {
                System.debug('Error inserting CarbonCredits: ' + ex.getMessage());
            }
        }
    }
}


