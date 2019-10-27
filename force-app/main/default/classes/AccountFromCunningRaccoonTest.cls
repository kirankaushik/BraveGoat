@isTest(seeAllData = true)
public class AccountFromCunningRaccoonTest{

	@isTest
	static void testInsertAccounts(){
		RestRequest request = new RestRequest();
		List<Account> records = [SELECT ID,Name,Rating,Industry FROM Account];
		String strJson = JSON.serialize(records);
		request.requestBody = Blob.valueOf(strJson);
		request.addHeader('content-type','application/json');
		request.httpMethod = 'POST';
		RestContext.request = request;
		AccountFromCunningRaccoon.insertAccountRecords();
	}
}