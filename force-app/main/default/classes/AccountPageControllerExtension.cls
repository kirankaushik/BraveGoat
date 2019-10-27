public class AccountPageControllerExtension {

    public Account account;
    
    public AccountPageControllerExtension(ApexPages.StandardController stdcon){
        this.account = (Account) stdcon.getRecord();
    }
    
    public String getWelcomeMessage(){
        String welcomeMessage = '';
        if(account.Id != NULL){
            return 'Welcome '+account.Name;
        }
        return 'Please create a new account';
    }
    
    public PageReference save(){
        UPSERT account;
        PageReference pageRef = new PageReference('/apex/OpportunityPage');
        pageRef.setRedirect(true);
        pageRef.getParameters().put('AccountId',account.Id);
        pageRef.getParameters().put('AccountName',account.Name);
        return pageRef;
    }
    
}