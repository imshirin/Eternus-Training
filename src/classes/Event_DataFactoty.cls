/*Event data factory*/

@isTest
public class Event_DataFactoty {
    public static void createEvents(integer noOfRecords, string jsonField)
    {
        list<event__c> event_List = new list<event__c> ();
        for(integer index = 0; index < noOfRecords; index++) {
            event__c record = new event__c (name = 'Event'+index,
            JSON__c = jsonField);
            event_List.add(record);
        }
        insert event_List;
    }
}