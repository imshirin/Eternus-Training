public with sharing class SearchAcross_sObject {

    //public list <selectOption> options {get;set;}
	public list <account> account_List {get;set;}
	public list <contact> contact_List {get;set;}
	public list <lead> lead_List {get;set;}
	public list <opportunity> opportunity_List {get;set;}
	public string searchstring {get;set;} 
	
	public SearchAcross_sObject () {
	}
	
	
	/*
    public List<SelectOption> getdynamiclist() {
       // List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--None--'));
        options.add(new SelectOption('Account','Account'));
        options.add(new SelectOption('Contact','Contact'));
        options.add(new SelectOption('Opportunity','Opportunity'));
        options.add(new SelectOption('Lead','Lead'));
        return options;
    }*/

	public void searchRecords(){ 
	   try {
	       if(searchstring !=null) {
		       string searchAccount = 'select name,id from account where name like \'%'+searchstring+'%\''; 
		       account_List = Database.query(searchAccount); 
		       string searchContact = 'Select name,id ,firstname ,lastname from contact where name like \'%'+searchstring+'%\' AND  lastname like \'%'+searchstring+'%\'  AND firstname like \'%'+searchstring+'%\'';
		       contact_List = Database.query(searchContact);
    	       string searchOpportunity = 'select name, id from opportunity where name like \'%'+searchstring+'%\'';
		       opportunity_List = Database.query(searchOpportunity);
		       string searchLead = 'select name, id from lead where name like \'%'+searchstring+'%\'';
		       lead_List = Database.query(searchLead);
		       
		       //flag = false;
		       }
	   }catch (exception e) {

    }
} 



	public void clear(){ 
	    try{
	        if(contact_List != null || contact_List.size() > 0)
			    contact_List.clear();
            if(account_List != null || account_List.size() > 0)
			    account_List.clear();
            if(opportunity_List != null || opportunity_List.size() > 0)
			    opportunity_List.clear();
            if(lead_List != null || lead_List.size() > 0)
			    lead_List.clear();
	    }catch (exception e) {

    }
	}
}
/*
 reRender="block2" 
 rendered="{if(account_List.size()!= 0)?true:false}"
 rendered="{if(account_List.size()!= 0)?true:false}"
 rendered="{if(Opportunity_List.size()!= 0)?true:false}"
 rendered="{if(Lead_List.size()!= 0)?true:false}"*/