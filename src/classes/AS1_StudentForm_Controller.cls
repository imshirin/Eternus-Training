public with sharing class AS1_StudentForm_Controller {
    ApexPages.StandardController stdObject;
    public string Language_code {get; set;}
    public string code {get; set;}
    public student__c record {get; set;}
    public list <selectOption> option {get; set;}
    
    
/*1.Settings for Extension and
At the time of page loading set first value in list*/

    public AS1_StudentForm_Controller (ApexPages.StandardController stdPageObject) {
        this.record = (student__c)stdPageObject.getRecord();
        stdObject = stdPageObject;
        option = new List <selectOption> ();
         if(language__c.getAll().values().size() > 0 || language__c.getAll().values() != null)
		     Language_code = language__c.getAll().values()[0].code__c;
		     addCSRecordsToList();
    }


/*2. Add custom setting records to select list */

    public void addCSRecordsToList () {
        set<String> setUniqueCode = new set<String>();
        for(language__c  settings : language__c.getAll().values()) {
            option.add(new SelectOption(settings.code__c, settings.name));
        }
    }


/*compare code value(of select list) with option list and set language code*/

    public void compareAndSetLanguage() {
        for(language__c  settings : language__c.getAll().values()) {
            if(settings.code__c == Language_code) {
                code = Language_code;
            }
        }
    }

/*Created customize save method*/

    Public PageReference customSave (){
	    try{
	       insert record;
	    } 
	    catch(DmlException e) {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.error, ''+e));
        }
		    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, System.Label.formSubmission));
	    return null;
	}
}