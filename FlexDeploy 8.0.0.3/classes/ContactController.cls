public class ContactController {
	public static void IdentifyGender(List<Contact> conList)
    {
        for(Contact con:conList)
        {
            if(con.Salutation == 'Mr.' || con.Salutation == 'Mr')
            {
                con.AssistantName = 'Male';
            }
            else if(con.Salutation == 'Mrs.' || con.Salutation == 'Ms.')
            {
                con.AssistantName = 'Female';
            }
            else if(con.Salutation == 'Dr.')
            {
                con.AssistantName = 'Doctor';
            }
            else if(con.Salutation == 'Prof.')
            {
                con.AssistantName = 'Professor';
            }
        }
    }
}