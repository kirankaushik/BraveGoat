public class RedirectTestController {

    public RedirectTestController(ApexPages.StandardController stdCon){
       
    }
    
    public PageReference Redirect(){
        PageReference pageRef = new PageReference('/apex/RedirectTest');
        pageRef.setRedirect(false);//preserves view state
        return pageRef;
    }
}