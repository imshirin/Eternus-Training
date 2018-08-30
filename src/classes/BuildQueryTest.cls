/* Test class for testing functionality of Query Builder */

@isTest
private class BuildQueryTest {

    @testSetup
    static void datafactory() 
    {
        Account_DataFactory.CreateRecords(100, 'espl');
    }
/*
 * Test for display functionality of controller class
 * Input : selectedObj - account
 * Expected Output : fields not empty
 */
    static testMethod void testAccountObjectSelectedScenario() 
    {
        Test.startTest();
        BuildQuery controller = new BuildQuery();
        controller.selectedObj = 'account';
        controller.accessFields();
        System.assert(controller.fields != NULL);
        System.assert(controller.fnotselected != NULL);
        System.assert(controller.fselected.isEmpty());
        System.assertEquals(true,controller.isObjSelected);
        System.assertEquals(controller.fieldsNotSelectedOptions.size(),controller.fields.size());
        System.assert(controller.fieldSelectedOptions.isEmpty());
        Test.stopTest();
    }
    
/*
 * Testing functionality of controller if object selected as 'None'
 * Input : selectedObj - None
 * Expected Output : isObjSelected -  false
                     isQueryExecuted -false 
 */
    static testMethod void testNoneObjectSelectedScenario()
    {
        Test.startTest();
        BuildQuery controller = new BuildQuery();
        controller.selectedObj = 'account';
        controller.accessFields();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        controller.selectedObj = 'None';
        controller.accessFields();
        System.assertEquals(false,controller.isObjSelected);
        System.assertEquals(false,controller.isQueryExecuted);
        Test.stopTest();
    }
    
/*
 * Test for add fields and remove fields functionality of controller class
 * Input : selectedObj -      account
 *         selected fields -  AccountNumber, Name
 * Expected Output : selected fields - AccountNumber, Name
 *
 * Input : deselected fields -AccountNumber
 * Expected Output : selected fields -  Name
 *                   deselected fields- AccountNumber
 */
    static testMethod void testFieldSelectedScenario()
    {
        Test.startTest();
        BuildQuery controller = new BuildQuery();
        controller.selectedObj = 'account';
        controller.accessFields();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        System.assert(controller.fselected != NULL);
        System.assert(controller.fselected.contains('AccountNumber'));
        System.assert(controller.fselected.contains('Name'));
        System.assert(!controller.fnotselected.contains('AccountNumber'));
        System.assert(!controller.fnotselected.contains('Name'));
        controller.rfields.add('AccountNumber');
        controller.removeFields();
        System.assert(controller.fnotselected.contains('AccountNumber'));
        System.assert(!controller.fselected.contains('AccountNumber'));
        Test.stopTest();
    }


/*
 * Testing functionality of generateQuery
 * Input : selectedObj - account
 *         selected fields - AccountNumber, Name
 * Expected Output : 10 records
 */
    static testMethod void testGenerateQueryScenario()
    {
        Test.startTest();
        BuildQuery controller = new BuildQuery();
        controller.selectedObj = 'account';
        controller.accessFields();
        controller.sfields.add('AccountNumber');
        controller.sfields.add('Name');
        controller.addFields();
        System.assertEquals(false,controller.isQueryExecuted);
        controller.generateQuery();
        System.assertEquals(true,controller.isQueryExecuted);
        System.assertEquals('SELECT AccountNumber,Name FROM account ORDER BY Id ASC LIMIT 500',controller.query);
        System.assertEquals(100,controller.result.size());
        controller.rfields.add('AccountNumber');
        controller.removeFields();
        controller.generateQuery();
        Test.stopTest();
        System.assertEquals('SELECT Name FROM account ORDER BY Id ASC LIMIT 500',controller.query);
        System.assertEquals(100,controller.result.size());
    }
    
/*
 * Test for generateQuery methods of controller, with no fields selected
 * Input : None of fields selected
 * Expected Output: error message
 */
    static testMethod void testGenerateQueryWithNoFieldsScenario()
    {
        Test.startTest();
        PageReference pageRef = Page.BuildQueryPage;
        Test.setCurrentPage(pageRef);
        BuildQuery controller = new BuildQuery();
        controller.selectedObj = 'account';
        controller.accessFields();
        System.assertEquals(false,controller.isQueryExecuted);
        controller.generateQuery();
        System.assertEquals('SELECT  FROM account ORDER BY Id ASC LIMIT 500',controller.query);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals('Please select fields to query',msgs[0].getDetail());
        Test.stopTest();
    }
}