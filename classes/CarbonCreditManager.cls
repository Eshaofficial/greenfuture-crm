public with sharing class CarbonCreditManager {
    public static void createCreditsForCompletedProjects(List<SustainabilityProject__c> projects) {
        if (projects == null || projects.isEmpty()) return;

        List<Carbon_Credit__c> creditsToInsert = new List<Carbon_Credit__c>();

        for (SustainabilityProject__c p : projects) {
            if (p.Status__c == 'Completed') {
                Carbon_Credit__c c = new Carbon_Credit__c();
                c.Name = p.Name + ' Credit';
                Decimal creditVal = 100;
                if (p.Project_Budget__c != null && p.Project_Budget__c > 0) {
                    creditVal = Math.max(1, (p.Project_Budget__c / 1000).setScale(0));
                }
                c.Credit_Amount__c = creditVal;
                c.Type__c = 'Earned';
                c.Date_Recorded__c = Date.today();
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
                System.debug('Error inserting Carbon Credits: ' + ex.getMessage());
            }
        }
    }
}