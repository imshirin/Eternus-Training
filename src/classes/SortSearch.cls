@isTest
private class SortSearch {

   static testMethod void constructorTest() {
       test.startTest();
           List<Contact> contacts = Contact_DataFactory.CreateContactRecords(100, '', '', '');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
       test.stopTest();
       System.assertEquals(100, s.contactList.size());
       System.assertEquals(100, s.showContacts.size());
   }
   
   static testMethod void displayByAlphabetTest() {
       test.startTest();
           List<Contact> contacts = Contact_DataFactory.CreateContactRecords(100, 'Test', '', '');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'T';
           s.display();
       test.stopTest();
       System.assertEquals(100, s.showContacts.size());
   }

   static testMethod void displayAllTest() {
       test.startTest();
           List<Contact> contacts = Contact_DataFactory.CreateContactRecords(100, '', '', '');
           ContactAlphabeticalSearch s=new ContactAlphabeticalSearch();
           s.searchAlphabet = 'All';
           s.display();
       test.stopTest();
       System.assertEquals(100, s.showContacts.size());
   }
   
   static testMethod void remoteTest() {
       test.startTest();
           List<Contact> contacts = Contact_DataFactory.CreateContactRecords(100, '', '', '');
           Contact contact = [Select Id,Name from Contact][0];
           Id contactId = contact.id;
           ContactAlphabeticalSearch.deleteContact(contactId);
       test.stopTest();
       List<contact> conlist = [Select Id from Contact];
       System.assertEquals(99, conlist.size());
   }
}