@isTest
public class Contact_DataFactory {

    public static list<contact> CreateContactRecords(integer numberOfRecords, String ConFirstname, String Conlastname, String emailId) {
        list <contact> contact_List = new list <contact> ();
        contact record;
        for (integer index = 1; index <= numberOfRecords; index++) {
            record = new contact (firstname = ConFirstname+index, lastname = Conlastname+index, email = emailId);
            contact_List.add(record);
        }
        insert contact_List;
        return contact_List;
    }
    
    
    /*public static list<contact> CreateContactRecords(integer numberOfRecords, String Contactlastname, String emailId) {
        list <contact> contact_List = new list <contact> ();
        contact record;
        for (integer index = 1; index <= numberOfRecords; index++) {
            record = new contact (lastname = Contactlastname+index, email = emailId);
            contact_List.add(record);
        }
        insert contact_List;
        return contact_List;
    }*/
}