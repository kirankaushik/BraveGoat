public class SendAccountUsingCallout {

	@future(callout=true)    
    public static void sendAccount(List<ID> accountsId){
        String accountName = [SELECT ID,Name FROM Account WHERE ID = :accountsId.get(0)].Name;
        String endPoint = 'callout:Resourceful_Raccoon/services/data/v45.0/sobjects/account';
        String jsonString = '{"Name":"' +accountName+ '"}';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(endPoint);
        request.setMethod('POST');
        request.setHeader('content-type','application/json');
        request.setBody(jsonString);
        HttpResponse response  = http.send(request);
        system.debug(response.getStatusCode()+' '+response.getStatus());
        system.debug(response.getBody());
    }
}