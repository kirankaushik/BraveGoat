public class OpportunityPageControllerExtension {

    public Id accountId;
    public String accountName { get; set; }
    public Opportunity opportunity;
    
    public OpportunityPageControllerExtension(ApexPages.StandardController stdcon){
        this.opportunity = (Opportunity) stdcon.getRecord();
        accountName = ApexPages.currentPage().getParameters().get('AccountName');
        accountId = ApexPages.currentPage().getParameters().get('AccountId');
    }
    
    public PageReference save(){
        opportunity.AccountId = accountId;
        INSERT opportunity;
        PageReference pageRef = new pageReference('/'+opportunity.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference cancel(){
        PageReference pageRef = new PageReference('/apex/AccountPage?Id='+accountId);
        pageRef.setRedirect(true);
        return pageRef;
    }
}