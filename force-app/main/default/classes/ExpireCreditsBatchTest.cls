@IsTest
private class ExpireCreditsBatchTest {
    @IsTest static void testExpireOldCredits() {
        CarbonCredit__c oldCredit = new CarbonCredit__c(
            Name = 'Old Credit',
            Credit_Amount__c = 10,
            Date_Recorded__c = Date.today().addYears(-2),
            Status__c = 'Active',
            Type__c = 'Earned'
        );
        CarbonCredit__c newCredit = new CarbonCredit__c(
            Name = 'New Credit',
            Credit_Amount__c = 5,
            Date_Recorded__c = Date.today(),
            Status__c = 'Active',
            Type__c = 'Earned'
        );
        insert new List<CarbonCredit__c>{ oldCredit, newCredit };

        Test.startTest();
            Database.executeBatch(new ExpireCreditsBatch(), 2);
        Test.stopTest();

        CarbonCredit__c refreshedOld = [SELECT Id, Status__c FROM CarbonCredit__c WHERE Id = :oldCredit.Id];
        CarbonCredit__c refreshedNew = [SELECT Id, Status__c FROM CarbonCredit__c WHERE Id = :newCredit.Id];

        System.assertEquals('Inactive', refreshedOld.Status__c, 'Old credit should be marked Inactive');
        System.assertEquals('Active', refreshedNew.Status__c, 'New credit should remain Active');
    }
}
