//Find all the Lead records having Status as Won & update the stage with New
// value

public with sharing class PM1_4 {
    public void updateLead()
    {
    try{
        list<lead> leadlist = new list<lead>([select id, lastname, company, status from lead where status = 'Closed - Not Converted']);
        system.debug(leadlist);
        for(lead l : leadlist)
        {
        l.status = 'Closed - Converted';
        }
        update leadlist;
    
        
    }catch(exception e){
        
    }
    }
}