@IsTest
private class ProjectTriggerTest {

    // 🔹 Helper: Create a Partner__c record safely
    private static Partner__c createPartner() {
        Partner__c partner = new Partner__c(
            Name = 'UnitTest Partner',
            Partner_Type__c = 'NGO',
            Status__c = 'Active',
            Email__c = 'testpartner@example.com'
        );
        insert partner;
        return partner;
    }

    // 🔹 Helper: Create a SustainabilityProject__c record safely
    private static SustainabilityProject__c createProject(Id partnerId) {
        SustainabilityProject__c proj = new SustainabilityProject__c(
            Name = 'UnitTest Project',
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(10),   // End Date > Start Date
            Status__c = 'In Progress',                // initial status
            Project_Budget__c = 5000,
            Priority__c = 'Medium',                   // picklist default
            Project_Type__c = 'Sustainability',      // picklist default
            Approval_Status__c = 'Pending',          // picklist default
            Partner__c = partnerId                    // required lookup
        );
        insert proj;
        return proj;
    }

    // 🔹 TEST METHOD: Ensure project completion creates Carbon Credit
    @IsTest static void testCompletionCreatesCredit() {
        // 1. Create required partner
        Partner__c partner = createPartner();

        // 2. Create a valid project linked to the partner
        SustainabilityProject__c proj = createProject(partner.Id);

        // 3. Update status to Completed → triggers credit creation
        Test.startTest();
            proj.Status__c = 'Completed';
            update proj;
        Test.stopTest();

        // 4. Assert that a Carbon Credit record is created
        List<Carbon_Credit__c> credits = [
            SELECT Id, Name, Status__c, Credit_Amount__c, Project__c
            FROM Carbon_Credit__c
            WHERE Project__c = :proj.Id
        ];
        System.assertEquals(1, credits.size(), 'One credit should be created for completed project');
        System.assertEquals('Active', credits[0].Status__c, 'New credit should be Active');
        System.assert(credits[0].Credit_Amount__c > 0, 'Credit amount should be positive');
    }

    // 🔹 TEST METHOD: ExpireCreditsBatch test
    @IsTest static void testExpireCreditsBatch() {
        // Create partner and project
        Partner__c partner = createPartner();
        SustainabilityProject__c proj = createProject(partner.Id);

        // Create old and new credits
        Carbon_Credit__c oldCredit = new Carbon_Credit__c(
            Name = 'Old Credit',
            Credit_Amount__c = 10,
            Date_Recorded__c = Date.today().addYears(-2),
            Status__c = 'Active',
            Type__c = 'Earned',
            Project__c = proj.Id,
            Source__c = 'Internal'
        );
        Carbon_Credit__c newCredit = new Carbon_Credit__c(
            Name = 'New Credit',
            Credit_Amount__c = 5,
            Date_Recorded__c = Date.today(),
            Status__c = 'Active',
            Type__c = 'Earned',
            Project__c = proj.Id,
            Source__c = 'Internal'
        );
        insert new List<Carbon_Credit__c>{ oldCredit, newCredit };

        // Execute batch
        Test.startTest();
            Database.executeBatch(new ExpireCreditsBatch(), 2);
        Test.stopTest();

        // Verify old credit is Inactive, new credit still Active
        Carbon_Credit__c refreshedOld = [SELECT Status__c FROM Carbon_Credit__c WHERE Id = :oldCredit.Id];
        Carbon_Credit__c refreshedNew = [SELECT Status__c FROM Carbon_Credit__c WHERE Id = :newCredit.Id];

        System.assertEquals('Inactive', refreshedOld.Status__c, 'Old credit should be Inactive');
        System.assertEquals('Active', refreshedNew.Status__c, 'New credit should remain Active');
    }

    // 🔹 TEST METHOD: CarbonPriceService future method test
    @IsTest static void testCarbonPriceServiceFuture() {
        Test.startTest();
            CarbonPriceService.fetchCarbonPrice('https://mockendpoint.example.com');
        Test.stopTest();
        // No assertion needed – just ensure callout runs without errors
    }
}