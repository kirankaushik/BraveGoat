public class SendAccountRecordsUsingCallout {

    /*@future(callout=true)
    public static void sendAccounts(List<ID> accountIds){
        List<Object> accountRecords = [SELECT ID,Name,Industry FROM Account WHERE ID IN : accountIds];
        String jsonString = JSON.serialize(accountRecords);
        system.debug(jsonString);
        String endPoint = 'callout:Resourceful_Raccoon/services/apexrest/insertAccounts/';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(endPoint);
        request.setMethod('POST');
        request.setHeader('content-type','application/json');
        request.setBody(jsonString);
        HttpResponse response = http.send(request);
        system.debug(response.getStatusCode()+' '+response.getStatus());
        system.debug(response.getBody());
    }*/
}