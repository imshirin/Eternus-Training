/*scheduler for Batch_ClosedWonOpportunity*/

global with sharing  class BAtch_ClosedWonOpportunity_Scheduler implements schedulable{
    global void execute(SchedulableContext sc) {
        Batch_ClosedWonOpportunity obj = new Batch_ClosedWonOpportunity ();
        database.executeBatch(obj);
    }
}