@isTest
public class EFT_Transaction_Status_DataFactory {

    
    public static list<EFT_Transaction_Status__C> CreateEFT_Transaction_StatusRecords(integer numberOfRecords, String status, String inputDate) {
        list <EFT_Transaction_Status__C> EFT_Transaction_List = new list <EFT_Transaction_Status__C> ();        
        EFT_Transaction_Status__C record;
        for (integer index = 1; index <= numberOfRecords; index++) {
            record = new EFT_Transaction_Status__C (Name = 'EFT_Transaction'+index, 
            Transaction_Status__c = status, 
            Transaction_Date__c = System.today());
            EFT_Transaction_List.add(record);
        }
        insert EFT_Transaction_List;
        return(EFT_Transaction_List);
    }

}