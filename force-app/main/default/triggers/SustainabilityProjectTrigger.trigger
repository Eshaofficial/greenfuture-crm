trigger SustainabilityProjectTrigger on SustainabilityProject__c (after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        SustainabilityProjectTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}

