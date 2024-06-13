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
    
    public static void getAmount(List<Account> accList, Map<Id,Account> oldMap)
    {
        Set<ID> accID = New Set<ID>();
        for(Account acc:accList)
        {
            if(acc.Active__c == 'Yes' && acc.Active__c != oldMap.get(acc.Id).Active__c)
            {
                accID.add(acc.Id);
            }
        }
        
        if(!accID.isEmpty())
        {
            Double totalAmt = 0;
            for(Opportunity opp:[SELECT ID, Amount FROM Opportunity WHERE AccountID IN :accID])
            {
                totalAmt = totalAmt + opp.Amount;
            }
            
            for(Account acc:accList)
            {
                acc.AnnualRevenue = totalAmt;
            }
        } 
    }
}