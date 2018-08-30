// Write a SQOL Query to show Child Parent relationship and print the result.

public with sharing class PM1_5 {
    public void parentChild()
    {
        try{
            list<Opportunity> opp = [select id, account.name, amount, name from Opportunity];
            System.debug(opp);
            
            list <account> acc = [select id, name, (select lastname from contacts) from account where name = 'eternus'];
            for(account accobj : acc){
                System.debug(acc);
            }
        }catch(exception e){
            
        }
    }
}