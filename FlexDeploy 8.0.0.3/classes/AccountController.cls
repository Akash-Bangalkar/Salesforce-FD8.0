public class AccountController {
	public static void updateRating(List<Account> accList, Map<Id,Account> oldMap)
    {
        for(Account acc:accList)
        {
            if(acc.Ownership == 'Public' && acc.Ownership != oldMap.get(acc.Id).Ownership)
            {
                acc.Rating = 'Hot';
            }
            else if(acc.Ownership == 'Private' && acc.Ownership != oldMap.get(acc.Id).Ownership)
            {
                acc.Rating = 'Cold';
            }
            else
            {
                acc.Rating = 'Warm';
            }
        }
    }
}