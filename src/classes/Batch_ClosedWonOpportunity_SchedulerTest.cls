/*Test class for scheduler of Batch_ClosedWonOpportunity*/

@isTest
public class Batch_ClosedWonOpportunity_SchedulerTest {

    static testMethod void myUnitTest() {
        Test.startTest();
        BAtch_ClosedWonOpportunity_Scheduler obj = new BAtch_ClosedWonOpportunity_Scheduler();
        String cronExp = '0 0 0 * * ? *';
        system.schedule('Batch Scheduler', cronExp, obj); 
        Test.stopTest();
    }
}