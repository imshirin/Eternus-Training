public with sharing class ABC_Container_Extension {
   public TrainingData__Invoice__c invoice{get;set;}
   public Map<String,Double> mapExpenses{get;set;}
   public List<String> keyMap{get;set;}
   public ABC_Container_Extension (ApexPages.StandardController abc)
   {
       invoice = (TrainingData__Invoice__c)abc.getRecord();
       invoice = [SELECT id, TrainingData__Service_Charges__c, TrainingData__Total_LabourCost__c ,
       TrainingData__Discount__c ,Tax__c, TrainingData__Total__c FROM 
       TrainingData__Invoice__c WHERE Id =: invoice.Id];
       mapExpenses = new Map<String,Double>();
       keyMap = new List<String>(); 
       System.debug('Invoice Info:::'+invoice);
       mapExpenses.put('Service Fee', invoice.Service_Charges__c);
       System.debug(':::After Service Fee');
       mapExpenses.put('Labour Cost', invoice.Total_LabourCost__c);
       System.debug(':::After Labour Cost');
       mapExpenses.put('Discount', invoice.Discount__c);
       System.debug(':::After Discount');
       mapExpenses.put('Tax', invoice.Tax__c);
       mapExpenses.put('Total', invoice.Total__c);
       keyMap.addAll(mapExpenses.keySet());
       System.debug('Map:::::'+mapExpenses);
   }
}