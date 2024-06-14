trigger ConTrigger on Contact (before insert, before update, after update) {
    if(trigger.isBefore)
    {
       
    }
    else if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
            ContactController.changeEmail(trigger.new, trigger.oldMap);
        }
    }
}
