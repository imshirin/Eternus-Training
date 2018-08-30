/*Test class to test functionality of Admission form*/
@isTest


public class AS1_StudentForm_Test {
    
    @testSetup
    /*creating data factory*/
    public static void createDataFactory() {
        list<Language__c> Language_List = new list <Language__c>();
            Language__c record1 = new Language__c();
            record1.Name = 'English';
            record1.code__c = 'en';
            Language_List.add(record1);
            Language__c record2 = new Language__c();
            record2.Name = 'French';
            record2.code__c = 'fr';
            Language_List.add(record2);
            Language__c record3 = new Language__c();
            record3.Name = 'Spanish';
            record3.code__c = 'es';
            Language_List.add(record3);
            insert Language_List;

    }
 

    static testMethod void testFunctionality() {
        student__c record = new student__c(name = 'Lovely', gender__c = 'female');
        ApexPages.StandardController sc = new ApexPages.standardController(record);
        AS1_StudentForm_Controller obj= new AS1_StudentForm_Controller(sc);
        Test.StartTest();
        obj.Language_code = 'es';
        obj.addCSRecordsToList ();
        obj.compareAndSetLanguage ();
        obj.customSave();
        System.assertEquals(obj.Language_code, obj.code);
            
        obj.Language_code = 'fr';
        obj.addCSRecordsToList ();
        obj.compareAndSetLanguage ();
        obj.customSave();
        System.assertEquals(obj.Language_code, obj.code);
        Test.StopTest();
    }
}