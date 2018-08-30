/*SOQL query to find all Account records where 'Billing State' is not
'Maharashtra' and'Kerala'. Ordering the results by Billing State in descending
order with null values at the end. Displaying first
10,000 records only without use AND operator*/

public with sharing class PM2_5 {
    public void getRecords()
    {
        try{
        list<account> acc = new list<account>([select id, name, BillingState from account where BillingState not in ('Maharashtra', 'Kerala') order by BillingState desc NULLS LAST limit 10000]);
        System.debug(acc);
        }catch(exception e){
        }
    }
}