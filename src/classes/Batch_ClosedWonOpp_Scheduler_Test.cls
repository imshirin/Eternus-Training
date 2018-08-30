@isTest
private class Batch_ClosedWonOpp_Scheduler_Test {

    static testMethod void myUnitTest() {
        Test.startTest();
        BAtch_ClosedWonOpportunity_Scheduler obj = 
        new BAtch_ClosedWonOpportunity_Scheduler();
        String cronExp = '0 0/3 * * * ? *';
        system.schedule('Batch Scheduler', cronExp, obj); 
        Test.stopTest();
    }
}