//Prepare the map structures 

public with sharing class PM2_3new {
    
    // Account Name as key and AccountId as value.
    public void map1(){
        try{
	        list<account> acclist= [SELECT Id, name 
	                                FROM account];
	        map<string, id> accountMap =new map<string, id>();
	        for(account obj : acclist){
	            accountMap.put(obj.name, obj.id);
	        }
            System.debug(accountMap);
        }catch(exception e){
        }
    
            }
    
    // Account Id as key and entire Account object as value.
    public void map2(){
        try{
            map<id, account> accountMap =new map<id, account>
            ([SELECT Id, name FROM account]);
            System.debug(accountMap);
            }catch(exception e){ 
            }
        }
    }