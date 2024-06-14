trigger AccTrigger on Account (before update) {
	if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            AccountController.updateRating(trigger.new, trigger.oldMap);
        }
    }
}
