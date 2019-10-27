public class UpsertAccountController {

    public Account account { get; set; }
    public String accountId;
    
    public UpsertAccountController(){
        accountId = ApexPages.currentPage().getParameters().get('Id');
        account = (accountId == NULL) ? new Account() : [SELECT ID,Name,NumberOfEmployees,Industry,Rating FROM Account WHERE ID = :accountId];
    }
    
    public PageReference save(){
        UPSERT account;
        PageReference objPageReference = new PageReference('/'+account.Id);
        objPageReference.setRedirect(true);
        return objPageReference;
    }
    
    public PageReference cancel(){
        PageReference objPageReference = (accountId == NULL) ? new PageReference('/apex/UpsertAccount') : new PageReference('/apex/UpsertAccount?id='+accountId);
        objPageReference.setRedirect(true);
        return objPageReference;
    }
}