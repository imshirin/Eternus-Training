@isTest
public  class Lead_DataFactory {

    public static list<lead> createLeadReacord(integer numberOfRecords, String name, String company, String lead_RSVP) {
         list<lead> leadlist = new list<lead>();
         lead leadRecord;
        
        for(integer index = 0; index < numberOfRecords; index++) {
            leadRecord= new Lead(lastname = name+index, company=company,
            TrainingData__RSVP__c = lead_RSVP);
            leadlist.add(leadRecord);
          
        }
    insert leadlist;
        return leadlist;
    }
    
    /*create lead for Batch*/
    public static list<lead> createBatchLeadReacord(integer numberOfRecords, String name, String email, string mobile) {
         list<lead> leadlist = new list<lead>();
         lead leadRecord;
        
        for(integer index = 0; index < numberOfRecords; index++) {
            leadRecord= new Lead(lastname = name+index,  company = 'ESPL',
            email=email+index+'@gmail.com',
            MobilePhone = mobile+index);
            leadlist.add(leadRecord);
          
        }
    insert leadlist;
        return leadlist;
    }
    
    /*create lead for REST and SOAP*/
    public static list<lead> createLead(integer numberOfRecords, String firstname, String lastname, String email, string phone, string company) {
         list<lead> leadlist = new list<lead>();
        
        for(integer index = 0; index < numberOfRecords; index++) {
            lead record = new lead ();
            record.firstName = firstname;
            record.lastName = lastname +index;
            record.company = company;
            record.Email = email +index+'@test.com';
            record.Phone = phone+index;
            leadlist.add(record);
        }
    insert leadlist;
    return leadlist;
    }
}