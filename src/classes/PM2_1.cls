public with sharing class PM2_1 {
    
    // Query on all Contact records, adding them to the List and Printing 
    //contents of list.
    
    public void displayContacts()
    {
        try {
            list<contact> contactList =
            [select id, firstname, lastname from contact];
            for(contact cobj : contactList){            
                System.debug(cobj.id);
                system.debug('--------'+cobj.firstname);
                System.debug('*****'+cobj.lastname);
            }
            }
        catch(Exception e) {
            }
    }
}