/* Test class for testing functionality of REST web service
 */

@isTest
public with sharing class REST_LeadUpdationService_Test {
    
/*Positive scenario to test functionality of post method
 *criteria :
 *firstName = Test
 *lastName = Demo
 *email = demo@test.com
 *company = ESPL
 */
    static testMethod void test_doPost() {
        test.startTest();
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = new RestResponse();
        REST_LeadManipulationService.doPost('Test','Demo','demo@test.com','2345678','ESPL');
        lead record = [select id, firstName, lastName, email, company from lead][0];
        System.assert(record.id !=null );
        System.assertEquals('Test', record.firstName);
        System.assertEquals('Demo', record.lastName);
        System.assertEquals('demo@test.com', record.email);
        System.assertEquals('ESPL', record.company);
        Test.stopTest();
    }
    
    /*Negative scenario to test functionality of post method
     *criteria :
     *firstName = Test
     *lastName = null
     *email = demo@test.com
     *company = ESPL
     */
    static testMethod void test_doPost_NegScenario() {
        test.startTest();
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = new RestResponse();
        REST_LeadManipulationService.doPost('Test','','demo@test.com','2345678','ESPL');
        list<lead> record = [select id from lead];
        System.assert(record.isEmpty());
        Test.stopTest();
    }
    
    
    /*Positive scenario to test functionality of post method
    *criteria :
    *firstName = Test
    *lastName = Lead
    *email = lead@test.com
    *phone = 7845698512
    */
    static testMethod void test_doDelete() {
        test.startTest();
        list<lead> Record_List =
        Lead_DataFactory.createLead(1, 'Test','Lead', 'lead', '7845698512','ESPL');
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';  
        request.addParameter('FName', 'Test');
        request.addParameter('LName', 'Lead');
        request.addParameter('EmailId', 'lead1@gmail.com');
        request.addParameter('phone', '7845698512');

        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = response;
        REST_LeadManipulationService.doDelete();
        System.assertEquals(0, [select id from lead where firstname = 'lead1@gmail.com'].size() );
        Test.stopTest();
    }

    /*Negative scenario to test functionality of post method
    *criteria :
    *firstName = Test
    *lastName = null
    *email = lead@test.com
    *phone = 7845698512
    */
    static testMethod void test_doDelete_NegScenario() {
        test.startTest();
        list<lead> Record_List =
        Lead_DataFactory.createLead(1, 'Test','Lead', 'lead', '7845698512','ESPL');
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';  
        request.addParameter('FName', 'Test');
        request.addParameter('LName', 'Lead');
        request.addParameter('EmailId', 'lead1@gmail.com');
        request.addParameter('phone', '7845698512');

        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = response;
        REST_LeadManipulationService.doDelete();
        lead record = [select id, firstName, lastName, email, company from lead][0];
        
        System.assert(record.id !=null);
        System.assertEquals('Test', record.firstName);
        System.assertEquals('Lead0', record.lastName);
        System.assertEquals('lead0@test.com', record.email);
        System.assertEquals('ESPL', record.company);
        Test.stopTest();
    }


    /*Positive scenario to test functionality of post method
    *criteria :
    *firstName = Test
    *lastName = Demo
    *email = new@test.com
    *phone = 7777777777
    */
    static testMethod void test_doPatch() {
        test.startTest();
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';
        request.httpMethod = 'patch';
        RestContext.request = request;
        RestContext.response = response;
        REST_LeadManipulationService.doUpdate('Test','Demo','new@test.com','7777777777');
        list<lead> Record_List = [select email,phone from lead];
        for(lead record : Record_List) {
            System.assertEquals('new@test.com', record.email);
            System.assertEquals('7777777777', record.phone);
        }
        Test.stopTest();
    }
    
    
    /*Negative scenario to test functionality of post method
    *criteria :
    *firstName = Test
    *lastName = null
    *email = lead@test.com
    *phone = 7845698512
    */
    static testMethod void test_doPatch_NegScenario() {
        test.startTest();
        list<lead> Record_List =
        Lead_DataFactory.createLead(1, 'Test','Lead', 'lead', '7845698512','ESPL');
        Restrequest request = new Restrequest();
        Restresponse response = new Restresponse();
        request.requestURI = '/services/apexrest/TrainingData/leadMapping';  
        request.addParameter('FName', 'Test');
        request.addParameter('LName', 'Lead');
        request.addParameter('EmailId', 'lead1@gmail.com');
        request.addParameter('phone', '7845698512');

        request.httpMethod = 'DELETE';
        RestContext.request = request;
        RestContext.response = response;
        REST_LeadManipulationService.doDelete();
        lead record = [select id, firstName, lastName, email, company from lead][0];
        
        System.assertEquals('lead0@test.com', record.email);
        System.assertEquals('ESPL', record.company);
        Test.stopTest();
    }
}