@isTest(seeAllData = true)
public class AccountsAndOpportunitiesRestResourceTest {

    @isTest
    static void testupsertRecords(){
        RestRequest request = new RestRequest();
        List<Object> recordsToSend = new List<Object>();
        List<Account> lstAccounts = new List<Account>();
        for(Account account : [SELECT ID,Name,Industry,Rating,(SELECT ID,Name,CloseDate,Amount,StageName FROM Opportunities) FROM Account]){
            recordsToSend.add(account);
            lstAccounts.add(account);
            recordsToSend.addAll(account.opportunities);
        }
        String strJson = JSON.serialize(recordsToSend);
        request.addHeader('content-type', 'application/json');
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf(strJson);
        RestContext.request = request;
        Test.startTest();
        AccountsAndOpportunitiesRestResource.upsertRecords();
        Test.stopTest();
        List<Opportunity> lstOpportunity = new List<Opportunity>();
        for(Account account : lstAccounts){
            Opportunity objOpportunity = new Opportunity();
            objOpportunity.Name = 'Test oppty 1';
            objOpportunity.CloseDate = system.today();
            objOpportunity.StageName = 'Prospecting';
            objOpportunity.Amount = 1000.0;
            objOpportunity.AccountId = account.Id;
            lstOpportunity.add(objOpportunity);
        }
        List<Object> recordsToSend2 = new List<Object>();
        recordsToSend2.addAll(lstAccounts);
        recordsToSend2.addAll(lstOpportunity);
        String strJson2 = JSON.serialize(recordsToSend2); 
        request.requestBody = Blob.valueOf(strJson2);//sending oppty which already has account
        //Test.startTest();
        AccountsAndOpportunitiesRestResource.upsertRecords();
        //Test.stopTest();
    }
}