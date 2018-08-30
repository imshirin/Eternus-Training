/**/

public with sharing class LogCLass {
   public static void createLeadRecords()
   {
       List<Lead> leadList = new List<Lead>();
       Lead leadRecord;
       AssignmentRule AR = new AssignmentRule();
       AR = [select id from AssignmentRule where SobjectType = 'Case' and
        Active = true limit 1];
       Database.DMLOptions dmlOpts = new Database.DMLOptions();
dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;

       for(Integer record = 11; record <= 18; record++)
       {
           leadRecord = new Lead(FirstName='Lead#'+string.valueOf(record),
                                 LastName='Record#'+string.valueOf(record),
                                 Company='ESPL',
                                 City='Pune',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOpts);
           leadList.add(leadRecord);
       }
       
       // Not inserted required field
       for(Integer record = 19; record <= 20; record++)
       {
           leadRecord = new Lead(FirstName='Lead#'+string.valueOf(record),
                                 Company='ESPL',
                                 Status='Open - Not Contacted');
           leadRecord.setOptions(dmlOpts);
           leadList.add(leadRecord);
       }

       Database.SaveResult[] saveList = Database.insert(leadList,false);
       List<TrainingData__Log__c> logList = new List<TrainingData__Log__c>();
       TrainingData__Log__c logRecord;
       for(Database.SaveResult saveRecord : saveList)
       {
           if(!saveRecord.isSuccess())
           {
               String errorMessage;
               for(Database.Error error : saveRecord.getErrors())
               {
                   errorMessage =+ error.getMessage();
               }
               logRecord = new Log__c(Error__c=errorMessage);
               logList.add(logRecord);
           }
       }
       insert logList;
   }
}