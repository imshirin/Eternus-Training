/*Handler for trigger which is generating new case as it satisfies the condition 
 as below.
SalesHeader__c.Status__c = “Open”
SalesHeader__c.Pick_Status__c = “Open”
SalesHeader__c.Total_Amount__c > 300
\\ Evaluate Bill to and Ship to fields to see if they match, if there is any
difference, create a case
IF (SalesHeader__c.Bill_to_Street__c <> SalesHeader__c.Ship_to_Street__c, OR
SalesHeader__c.Bill_to_City__c <> SalesHeader__c.Ship_to_City__c; OR
SalesHeader__c.Bill_to_Postal_Code__c <> SalesHeader__c.Ship_to_Postal_Code__c;
OR SalesHeader__c.Bill_to_State__c <> SalesHeader__c.Ship_to_State__c
*/

public class SalesHeaderTrigger_Header {
    
    /*Sales Header trigger handler*/
    public void method_SalesHeaderTrigger(list <SalesHeader__c> salesList){
        try{
            //creating assignment record type 
            String getRecordType = [Select Id From RecordType Where 
            SobjectType = 'case' and Name = 'assignment'].Id;
            AssignmentRule caseRule = new AssignmentRule();
	        caseRule = [select id from AssignmentRule where SobjectType = 'Case'
	        and Active = true limit 1];
	        Database.DMLOptions dmlOpts = new Database.DMLOptions();
	        dmlOpts.assignmentRuleHeader.assignmentRuleId= caseRule.id;
	        
	        list <case> caseList= new list<case>();
            case newRecord = new case();
            for(SalesHeader__c salesObject : salesList){
                if(salesObject.TrainingData__Pick_Status__c == 'Open' 
                    && salesObject.TrainingData__Status__c == 'Open' 
                    && salesObject.Total_Amount__c > 300) 
                    {
	                    if(salesObject.Bill_to_Street__c != salesObject.Ship_to_Street__c ||
	                    salesObject.Bill_to_City__c != salesObject.Ship_to_City__c ||
	                    salesObject.Bill_to_Postal_Code__c != salesObject.Ship_to_Postal_Code__c ||
	                    salesObject.Bill_to_State__c != salesObject.Ship_to_State__c )
	                    {
		                    newRecord = generateCase(salesObject, getRecordType, dmlOpts);
		                    caseList.add(newRecord);
		                }
                    }
                }
                
            insert caseList;
            
            }catch(exception e){
            
        }
    }
    
    
    /*Method to generate case*/
    public case generateCase(SalesHeader__c salesObject, string getRecordType, Database.DMLOptions dmlOpts ){
     
        //creating new record of case
       case Record = new case(Accountid = salesObject.TrainingData__Account__c,
                             contactid = salesObject.TrainingData__Contact__c,
                             RecordTypeid = getRecordType,
                             Origin = 'Internal',
                             Reason = 'Unable to Cross Ship',
                             priority = 'Medium',
                             Status = 'New',
                             Subject = Account.Name + ' ' + Case.Type,
                             Type = 'Unable to Cross Ship',
                             TrainingData__Open_Sales_Order__c = salesObject.Id,
                             Transaction_Status__c = salesObject.TrainingData__EFT_Transaction_Status__r.TrainingData__Transaction_Status__c,
                             TrainingData__Sales_Order_Number__c = salesObject.Name,
                             Order_Date__c = salesObject.TrainingData__EFT_Transaction_Status__r.TrainingData__Transaction_Date__c
                             );
       Record.setOptions(dmlOpts);
    return (Record);
    }
}