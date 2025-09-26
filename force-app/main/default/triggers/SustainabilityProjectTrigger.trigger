trigger SustainabilityProjectTrigger on SustainabilityProject__c (before insert, after insert, before update, after update) {
    if (Trigger.isAfter && Trigger.isUpdate) {
        SustainabilityProjectTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
    }
}
