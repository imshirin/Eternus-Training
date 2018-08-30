global with sharing class Batch_JSON implements Database.Batchable<sobject>,Database.stateful{

    String query = 'Select JSON__c, IsProcessed__c from Event__c where IsProcessed__c = false';
    global Database.QueryLocator start(Database.BatchableContext BC) {
       return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, list<Event__c> events)
    {
        Batch_JSON_Handler.createRecordsBasedOnEvents(events);
        
    }
    global void finish(Database.batchableContext bc) {
    }
}