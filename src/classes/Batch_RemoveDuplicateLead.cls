/*Batch to delete duplicate lead*/

global class Batch_RemoveDuplicateLead implements Database.Batchable<sObject>,
Database.stateful {
    String query = 'select id, name, email, MobilePhone from lead';
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute (Database.BatchableContext BC, list <lead> lead_List) {
        Batch_RemoveDuplicateLead_Handler.methodExecute(lead_List);
    }

    global void finish(Database.BatchableContext BC) {
    }
}

/*List<lead> l1 = new List<lead>();
set<lead> s1 = new set<lead>();
l1 = [select id from lead where name = 'Ali'];
s1.addAll(l1);
System.debug('l1-------'+l1);
System.debug('s1-------'+s1);
delete l1;
insert l1;*/