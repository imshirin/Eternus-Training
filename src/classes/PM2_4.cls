/*Get all account records where in selected 'Enrollment Year' is:
 a. 2010
 b. 2013 and 2014*/

public with sharing class PM2_4 {
    public void getData()
    {
	    try{
	       list<account> acc = new list<account>([select id, name, accountnumber, TrainingData__Enrollment_Year__c from account where (TrainingData__Enrollment_Year__c = '2010') OR (TrainingData__Enrollment_Year__c includes ('2013') AND TrainingData__Enrollment_Year__c includes('2014'))]);
	       system.debug(acc);
	    }catch(exception e){
	        
	    }
    }
}