@isTest

public class AS1_CountryCityDependentList_Test {
@testSetup

    public static void createDataFactory() {
        list<City__c> cityList = new list <City__c>();
        for(integer index = 1; index <= 3; index++) {
            City__c record = new city__c();
            record.Name = 'Pune'+index;
            record.Country__c = 'India';
            cityList.add(record);
        }
        for(integer index = 1; index < 2; index++) {
            City__c record = new city__c();
            record.Name = 'Newyork'+index;
            record.Country__c = 'USA';
            cityList.add(record);
        }
        insert cityList;
    }

    static testMethod void testFunctionality() {
        Test.StartTest();
        AS1_CountryCityDependentList_Controller obj =
        new AS1_CountryCityDependentList_Controller ();
        obj.country = 'India';
        obj.getCountries_List();
        obj.fetchCities();
        System.assertEquals(3, obj.City_List.size());
        obj.City_List.clear();
        obj.country = 'USA';
        obj.getCountries_List();
        obj.fetchCities();
        System.assertEquals(1, obj.City_List.size());
        Test.StopTest();
    }
}