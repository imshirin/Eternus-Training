@istest
public class SalesHeader_DataFactory {
	public static List<SalesHeader__c> createSalesHeaders(Integer numberOfRecords,
	decimal amount, integer inputIndex, string domain) {
	    list <Account> Account_List =
	    Account_DataFactory.CreateAccountRecords(1, 'Bill_to_Customer', domain);
	    list <Contact> Contact_List =
	    Contact_DataFactory.CreateContactRecords(1, '', 'Shaikh', 's@yahoo.com');
	    list <EFT_Transaction_Status__c> EFT_Transaction_Status_List =
	    EFT_Transaction_Status_DataFactory.CreateEFT_Transaction_StatusRecords(1, 'Complete', '');
	    List<SalesHeader__c> salesHeader_list = new List<SalesHeader__c>();
	    for (Integer index = inputIndex; index <= numberOfRecords; index++) {
	         SalesHeader__c record = new SalesHeader__c(
	         Total_Amount__c = amount,
	         Status__c = 'Open',
	         Pick_Status__c = 'Open',
	         Bill_To_Street__c = 'ABC Street',
	         Ship_To_Street__c = 'ABC Street',
	         Bill_To_State__c = 'Maharashtra',
	         Ship_To_State__c = 'Maharashtra',
	         Bill_To_City__c = 'Mumbai',
	         Ship_To_City__c = 'Mumbai',
	         Bill_To_Postal_Code__c = 123456,
	         Ship_To_Postal_Code__c = 123456);
	           
	         salesHeader_list.add(record);
	    }
	    insert salesHeader_list;
	    salesHeader_list = [select id from SalesHeader__c];
	    return salesHeader_list;
    }
}