/*Batch for collection of close won opportunity*/


global with sharing class Batch_ClosedWonOpportunity implements Database.Batchable<SObject>, Database.Stateful {
    global Map<string ,Map<String,List<Opportunity>>> mapObj =new Map<string ,Map<String,List<Opportunity>>>();
    global Map<Id,Double> aggregateAmountOnAccount = new Map<Id,Double>();

    global Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator(Batch_ClosedWonOpportunity_Handler.queryMethod());
    }

    global void execute(Database.BatchableContext bc, List<Account> acc_List){
        map<string,Map<String, List<opportunity>>> new_mapobj =
        Batch_ClosedWonOpportunity_Handler.methodExecute(acc_List, mapobj);
        
        for(string s : new_mapobj.keySet() ) {
            mapObj.put(s,new_mapobj.get(s));
        }
    }

    global void finish(Database.BatchableContext bc){
        Batch_ClosedWonOpportunity_Handler.finishMethod(mapObj);
    }
}