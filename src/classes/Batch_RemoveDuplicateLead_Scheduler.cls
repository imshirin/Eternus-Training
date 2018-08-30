global with sharing class Batch_RemoveDuplicateLead_Scheduler implements schedulable{
    global void execute(SchedulableContext SC) {
        Batch_RemoveDuplicateLead obj = new Batch_RemoveDuplicateLead ();
        Database.executeBatch (obj);
    }
}