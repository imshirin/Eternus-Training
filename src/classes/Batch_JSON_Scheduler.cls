/*Scheduler for JSON Batch*/

public with sharing class Batch_JSON_Scheduler implements schedulable{
    public void execute (schedulableContext SC) {
       Batch_JSON obj = new     Batch_JSON ();
       Database.executeBatch(obj);
    }
}