global class RestWrapperManager {

    global class AccountsAndOpportunitiesPutRestResource{
        global AccountsAndOpportunitiesPutRestResource(String strRequestType, List<Object> lstAccounts){
            if(strRequestType == 'PUT'){
                upsertRecords(lstAccounts);
            }
        }
        
        public void upsertRecords(List<Object> lstAccounts){
            Schema.SobjectField accountexternalId = Account.Fields.BraveBearId__c;
            Schema.SObjectField opportunityexternalId = Opportunity.Fields.BraveBearId__c;
            List<Account> lstAccountsToUpsert = new List<Account>();
            List<Opportunity> lstOpportunitiesToUpsert = new List<Opportunity>();
            Set<ID> setAccountIds = new Set<ID>();//Bravebear accounids
        
            for(Object account : lstAccounts){
                Map<String,Object> mapAccount = (Map<String,Object>) account;
                setAccountIds.add((String) mapAccount.get('Id'));
            }
            
            Map<ID,ID> externalIdMap = new Map<ID,ID>();
            for(Account account : [SELECT ID,BraveBearId__c FROM Account WHERE BraveBearId__c IN : setAccountIds]){
                externalIdMap.put(account.BraveBearId__c,account.Id);
            }
            Map<ID,List<Opportunity>> mapOpportunitiesToInsertLater = new Map<ID,List<Opportunity>>();
            List<Opportunity> lstOpportunitiesWithNewAccounts = new List<Opportunity>();
            
            for(Object account : lstAccounts){
                Map<String,Object> mapAccount = (Map<String,Object>) account;
                system.debug(mapAccount);
                if(mapAccount.containsKey('Id') && ((String) mapAccount.get('Id')).startsWith('001')){
                    system.debug('Its an account');
                    Account objAccount = new Account();
                    objAccount.Name = (String)mapAccount.get('Name');
                    objAccount.Rating = (String) mapAccount.get('Rating');
                    objAccount.Industry = (String) mapAccount.get('Industry');
                    objAccount.BraveBearId__c = (String) mapAccount.get('Id');
                    system.debug(mapAccount.get('Opportunities'));
                    Map<String,Object> lstOpportunitiesinScope = (Map<String,Object>) mapAccount.get('Opportunities');
                    if(lstOpportunitiesinScope != null && lstOpportunitiesinScope.containsKey('records') && lstOpportunitiesinScope.get('records') != null){
                        List<Object> lstOpportunititesToIterate = (List<Object>) lstOpportunitiesinScope.get('records');
                        for(Object opportunity : lstOpportunititesToIterate){
                            Opportunity objOpportunity = new Opportunity();
                            Map<String,Object> mapOpportunity = (Map<String,Object>) opportunity;
                            system.debug(mapOpportunity);
                            objOpportunity.Name = (String) mapOpportunity.get('Name');
                            objOpportunity.StageName = (String) mapOpportunity.get('StageName');
                            objOpportunity.CloseDate = Date.valueOf((String) mapOpportunity.get('CloseDate'));
                            objOpportunity.Amount = (Decimal) mapOpportunity.get('Amount');
                            objOpportunity.BraveBearId__c = (String) mapOpportunity.get('Id'); 
                            if(externalIdMap.containsKey((String) mapAccount.get('Id'))){
                                system.debug('Oppty has existing account');
                                objOpportunity.AccountId = (String) externalIdMap.get((String) mapAccount.get('Id'));
                                lstOpportunitiesToUpsert.add(objOpportunity);
                            }
                            else{
                                system.debug('oppty has new account');
                                objOpportunity.AccountId = (String) mapAccount.get('Id');//Initially assigning external id as accountid,this will be changed in below block
                                lstOpportunitiesWithNewAccounts.add(objOpportunity);
                            }
                        }     
                    }
                    
                
                mapOpportunitiesToInsertLater.put(objAccount.BraveBearId__c,lstOpportunitiesWithNewAccounts);
                lstAccountsToUpsert.add(objAccount);
                }
            }
            
            if(!lstAccountsToUpsert.isEmpty()){
                Database.upsertResult[] urList = Database.upsert(lstAccountsToUpsert,accountexternalId,FALSE);
            }
            if(!lstOpportunitiesToUpsert.isEmpty()){
                Database.UpsertResult[] lstOpportunitiesUpsertResult = Database.upsert(lstOpportunitiesToUpsert,opportunityexternalId,FALSE);    
            }
            
            for(Account account : [SELECT ID,BraveBearId__c FROM Account WHERE BraveBearId__c IN : setAccountIds]){
                externalIdMap.put(account.BraveBearId__c,account.Id);
            }
            
            List<Opportunity> lstOpportunitiesToInsert = new List<Opportunity>();
            for(Opportunity opportunity : lstOpportunitiesWithNewAccounts){
                opportunity.AccountId = externalIdMap.get(opportunity.AccountId);
                lstOpportunitiesToInsert.add(opportunity);
            }
            
            if(!lstOpportunitiesToInsert.isEmpty()){
                INSERT lstOpportunitiesToInsert;
            }
        }
    }
    

    global class AccountFromCunningRaccoonRestResource{

        global AccountFromCunningRaccoonRestResource(String type,List<Object> recordsToInsert){
            if(type == 'POST'){
                insertAccounts(recordsToInsert);
            }
        }

        public void insertAccounts(List<Object> recordsToInsert){
            List<Account> lstAccountsToInsert = new List<Account>();
            Schema.SObjectField externalId = Account.Fields.CunningRaccoon__c;
            for(Object account : recordsToInsert){
                Map<String,Object> mapAccounts = (Map<String,Object>) account;
                Account objAccount = new Account();
                objAccount.Name = (String) mapAccounts.get('Name');
                objAccount.Rating = (String) mapAccounts.get('Rating');
                objAccount.Industry = (String) mapAccounts.get('Industry');
                objAccount.CunningRaccoon__c = (String) mapAccounts.get('Id');
                lstAccountsToInsert.add(objAccount);
            }

            system.debug(lstAccountsToInsert);

            if(!lstAccountsToInsert.isEmpty()){
                Database.upsertResult[] urList = Database.upsert(lstAccountsToInsert,externalId,FALSE);
            }
        }
    }  
}