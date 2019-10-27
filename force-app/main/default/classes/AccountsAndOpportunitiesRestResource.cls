@RestResource(UrlMapping='/upsertAccountsAndOpptys/')
global class AccountsAndOpportunitiesRestResource {

    @HttpPut
    global static RestWrapperManager.AccountsAndOpportunitiesPutRestResource upsertRecords(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        system.debug(request.requestBody.toString());
        List<Object> lstAccounts = (List<Object>) JSON.deserializeUntyped(request.requestBody.toString());
        system.debug(lstAccounts);
        RestWrapperManager.AccountsAndOpportunitiesPutRestResource obj = new RestWrapperManager.AccountsAndOpportunitiesPutRestResource('PUT',lstAccounts);
        return obj;
    }
}