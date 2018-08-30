// SOQL query to retrieve and print all active Users. Preparing a Map having
// User Id as key and User record as value
public with sharing class PM2_2 {
    public void UserInfo(){
        try{
            map<id, user> userMAp =new map<id, user>([SELECT Id, username FROM User WHERE isactive = true]);
            System.debug(usermap);
            
       }catch(exception e){
        
       }
    }
}