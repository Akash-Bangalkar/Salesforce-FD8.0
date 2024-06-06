trigger ConTrigger on Contact (before insert, before update) {
	if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            ContactController.IdentifyGender(trigger.new);
        }
        else if(trigger.isUpdate)
        {
            ContactController.IdentifyGender(trigger.new);
        }
    }
}