public class OpptyListExtensionController {

    public List<Opportunity> lstOpportunities { get; set;}
    
    public OpptyListExtensionController(ApexPages.StandardSetController stdsetcon){
        //lstOpportunities = (List<Opportunity>) stdsetcon.getRecords(); 
        lstOpportunities = [SELECT ID,Name,Account.Name,StageName,CloseDate,Amount FROM Opportunity WHERE AccountId != NULL];
   }
}