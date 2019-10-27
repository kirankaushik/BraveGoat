public class OpportunityTableController {

    public ApexPages.StandardSetController setcon{
        get{
            if(setcon == NULL){
                setcon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT ID,Name,StageName,CloseDate,Amount,Account.Name FROM Opportunity WHERE AccountId != NULL]));
            }
            return setcon;
        }
        set;
    }
    
    public List<Opportunity> getOpportunities(){
		return (List<Opportunity>) setcon.getRecords();        
    }
}