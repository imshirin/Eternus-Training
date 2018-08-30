@isTest
public class SearchAcross_sObject_Test {

    static testMethod void testAccountSearchMethod() {
        
       list <Account> Acc_List =
       Account_DataFactory.CreateAccountRecords(10, 'Account', '');
       SearchAcross_sObject object_search = new SearchAcross_sObject();
       object_search.searchstring = 'acc';
       
       object_search.searchRecords();
       System.assertEquals(10, object_search.account_List.size());
    }

   static testMethod void testContactSearchMethod() {
        
       list <Contact> con_List =
       Contact_DataFactory.CreateContactRecords(10, 'Contact', 'Con', '');
       SearchAcross_sObject object_search = new SearchAcross_sObject();
       object_search.searchstring = 'con';
       object_search.searchRecords();
       System.assertEquals(10, object_search.contact_List.size());
    }
    
    static testMethod void testOpportunitySearchMethod() {
        
       list <opportunity> opp_List =
       DataFactory.createOpportunity(10, 'opportunity');
       SearchAcross_sObject object_search = new SearchAcross_sObject();
       object_search.searchstring = 'opp';
       
       object_search.searchRecords();
       System.assertEquals(10, object_search.opportunity_List.size());
    }
    
    static testMethod void testLeadSearchMethod() {
        
       list <Lead> lead_List =
       Lead_DataFactory.createLeadReacord(10, 'Lead', 'ESPL', '');
       SearchAcross_sObject object_search = new SearchAcross_sObject();
       object_search.searchstring = 'Lead';
       
       object_search.searchRecords();
       System.assertEquals(10, object_search.lead_List.size());
    }
    
    static testMethod void testClearMethod() {
        SearchAcross_sObject object_search = new SearchAcross_sObject();
       
	    list <Account> Acc_List =
	    Account_DataFactory.CreateAccountRecords(10, 'Account', '');
	       
	    list <Contact> con_List =
	    Contact_DataFactory.CreateContactRecords(10, 'Contact', 'Record', '');
	       
	    list <opportunity> opp_List =
	    DataFactory.createOpportunity(10, 'opportunity');
	       
	    list <Lead> lead_List =
	    Lead_DataFactory.createLeadReacord(10, 'Lead', 'ESPL', '');
	    object_search.searchstring = 'Lead';
	    object_search.searchRecords();
	       
	    object_search.clear();
	    System.assertEquals(0, object_search.lead_List.size());
	    System.assertEquals(0, object_search.opportunity_List.size());
	    System.assertEquals(0, object_search.contact_List.size());
	    System.assertEquals(0, object_search.account_List.size());
    }
}