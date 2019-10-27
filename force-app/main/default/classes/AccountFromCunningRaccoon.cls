@RestResource(UrlMapping='/insertAccounts/*')
global with sharing class AccountFromCunningRaccoon {
	
	@HttpPost
	global static RestWrapperManager.AccountFromCunningRaccoonRestResource insertAccountRecords(){
		RestRequest request = RestContext.request;
		RestResponse response = RestCOntext.response;
		List<Object> recordsToInsert = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
		system.debug(recordsToInsert);
		RestWrapperManager.AccountFromCunningRaccoonRestResource obj = new RestWrapperManager.AccountFromCunningRaccoonRestResource('POST',recordsToInsert);
		return obj;
	}
}