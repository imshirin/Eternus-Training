/* SOQL query to display 100 opportunity records with amount greater than
10,000 order by created date. Skip first 50 records and include records from 
recycle bin.*/ 

public with sharing class PM2_6 {
    public void getOpportunities(){
        try{
            Integer j = 10, cost = 9900;
            
            for(Integer i = 1; i<= 100; i++){
                Opportunity oppInsert = new Opportunity(name='opportunity'+i, stagename='Qualification', closedate= system.today(), amount = cost+j);
                insert oppInsert;
                
            }
            list<Opportunity> opplist = [select id, name, amount, createddate from Opportunity where amount > 10000 AND isDeleted = true order by createddate desc offset 50];
            system.debug(opplist);
        }catch(exception e){
        
        }
    }
}