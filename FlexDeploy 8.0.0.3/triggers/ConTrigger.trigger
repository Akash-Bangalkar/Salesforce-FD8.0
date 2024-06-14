trigger ConTrigger on Contact (before insert, before update, after update) {
	if(trigger.isBefore)
    {
       ContactController.uniqueValue(trigger.new, trigger.oldMap);
    }
    else if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
            ContactController.changeEmail(trigger.new, trigger.oldMap);
        }
    }
}