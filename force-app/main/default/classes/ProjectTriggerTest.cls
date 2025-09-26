@IsTest
private class ProjectTriggerTest {
    @IsTest static void testCompletionCreatesCredit() {
        SustainabilityProject__c proj = new SustainabilityProject__c(
            Name = 'UT Project',
            Start_Date__c = Date.today().addDays(-10),
            End_Date__c = Date.today().addDays(1),
            Project_Budget__c = 10000,
            Status__c = 'In Progress'
        );
        insert proj;

        Test.startTest();
            proj.Status__c = 'Completed';
            update proj;
        Test.stopTest();

        List<CarbonCredit__c> created = [SELECT Id, Project__c, Status__c, Type__c FROM CarbonCredit__c WHERE Project__c = :proj.Id];
        System.assertEquals(1, created.size(), 'A CarbonCredit should have been created for the completed project');
        System.assertEquals('Active', created[0].Status__c);
    }
}
