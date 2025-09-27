@IsTest
private class ProjectTriggerTest {

    @IsTest static void testCreateCredits() {
        // Create a project
        SustainabilityProject__c proj = new SustainabilityProject__c(
            Name = 'Test Project',
            Status__c = 'In Progress',
            ProjectBudget__c = 5000
        );
        insert proj;

        // Update project to Completed
        proj.Status__c = 'Completed';
        update proj;

        // Verify Carbon_Credit__c record created
        List<Carbon_Credit__c> credits = [SELECT Id, Name, Credit_Amount__c, Project__c FROM Carbon_Credit__c WHERE Project__c = :proj.Id];
        System.assertEquals(1, credits.size(), 'One credit should be created');
        System.assertEquals(proj.Id, credits[0].Project__c, 'Credit should be linked to the project');
    }
}
