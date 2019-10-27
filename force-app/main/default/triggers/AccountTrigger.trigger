trigger AccountTrigger on Account(after insert,after update){

    List<Account> lstAccountsToSend = new List<Account>();
    if(trigger.isInsert){
        for(Account account : trigger.new){
            lstAccountsToSend.add(account);
        }
    }

    if(!lstAccountsToSend.isEmpty()){
        
    }
}