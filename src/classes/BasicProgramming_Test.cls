@isTest
public class BasicProgramming_Test{
    static testMethod void EvenOddNumber_TestMethod( ) {
        Test.startTest();
        system.assertEquals('odd', BasicProgramming.testingEvenOddNumber(5));
        system.assertEquals('even', BasicProgramming.testingEvenOddNumber(4));
        system.assertEquals('0 is neither even nor odd number', BasicProgramming.testingEvenOddNumber(0));

        Test.stopTest();
    }  
}