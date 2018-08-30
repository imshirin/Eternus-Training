@isTest
private class SOAP_LeadManipulationService_Test {

    /* method to test creating lead functionality
     */
    public static testMethod void test_CreateLead() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        response = SOAP_LeadManipulatonService.createLead('test','lead','ESPL','lead@test.com','12345');

        list<lead> lead_List = [select id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assert(lead_List[0].id != null);
        system.assertequals('test',lead_List[0].FirstName);
        system.assertequals('lead',lead_List[0].lastName);
        system.assert(response.isSuccess);
        system.assertequals('success',response.status);
        Test.stopTest();
     }
     
    /* Negative scenario - method to test creating lead functionality
     *company - required field is not entered
     */
     public static testMethod void test_CreateLead_NegativeScenario() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        response = SOAP_LeadManipulatonService.createLead('test','','ESPL','lead@test.com','12345');

        list<lead> lead_List = [select FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertEquals(0, lead_List.size());
        system.assert(!response.isSuccess);
        Test.stopTest();
     }
     
    /* method to test functionality of lead deletion
     */
    public static testMethod void test_deleteLead() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        SOAP_LeadManipulatonService.createLead('test','lead','ESPL','lead@test.com','12345');
        Response = SOAP_LeadManipulatonService.deleteLead('test','lead','lead@test.com','12345');
        
        list<lead> lead_List = [select id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertEquals(0, lead_List.size());
        system.assert(response.isSuccess);
        system.assertequals('success',response.status);
        Test.stopTest();
    }

    /* Negative scenario - method to test functionality of lead deletion
     *criteria - trying to delete lead which does not exist
     */
     public static testMethod void test_DeleteLead_NegativeScenario() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        SOAP_LeadManipulatonService.createLead('test','lead','ESPL','lead@test.com','12345');
        Response = SOAP_LeadManipulatonService.deleteLead('test1','lead','lead@test.com','12345');
        
        list<lead> lead_List = [select id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assert(lead_List.size()> 0);
        system.assert(!response.isSuccess);
        Test.stopTest();
     }
     
    /* method to test functionality of lead updation
     */
    public static testMethod void test_updateLead() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        SOAP_LeadManipulatonService.createLead('test','lead','ESPL','lead@test.com','12345');
        Response = SOAP_LeadManipulatonService.updateLead('test','lead','lead@test.com','12345');
        
        list<lead> lead_List = [select id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assert(lead_List.size()>0);
        System.assertEquals('newlead@test.com',lead_List[0].email);
        System.assertEquals('99999995456',lead_List[0].phone);
        system.assert(response.isSuccess);
        system.assertequals('success',response.status);
        Test.stopTest();
    }
    
    /* Negative scenario - method to test functionality of lead updation
     *criteria - trying to update lead which does not exist
     */
    public static testMethod void test_UpdateLead_NegativeScenario() {
        Test.startTest();
        SOAP_LeadManipulatonService.Response response = new SOAP_LeadManipulatonService.Response();
        SOAP_LeadManipulatonService.createLead('test','lead','ESPL','lead@test.com','12345');
        Response = SOAP_LeadManipulatonService.updateLead('test1','lead1','lead@test.com','12345');
        
        list<lead> lead_List = [select id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertEquals('test',lead_List[0].firstName);
        system.assertEquals('lead',lead_List[0].lastName);
        system.assertEquals('lead@test.com',lead_List[0].email);
        system.assertEquals('12345',lead_List[0].phone);

        system.assert(!response.isSuccess);
        Test.stopTest();
    }
}