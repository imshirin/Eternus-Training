/*Creating dependent picklist*/

public class AS1_CountryCityDependentList_Controller {

    public String city { get; set; }
    public String country{get;set;}
    public List<SelectOption> City_List {get; private set;}


    /*Overriding constructor*/
    public AS1_CountryCityDependentList_Controller(){
        City_List =new  List<SelectOption>();
        if(TrainingData__City__c.getAll().values().size()> 0) {
            country = TrainingData__City__c.getAll().values()[2].Country__c;
        }
        fetchCities();
    }


    /*For getting country list from custom settings object*/
    public List<SelectOption> getCountries_List(){ 
        List<SelectOption> options = new List<SelectOption>(); 
	    set<String> setUniqueCountry = new set<String>();
	    for(TrainingData__City__c setting : TrainingData__City__c.getAll().values()){
		    if(!setUniqueCountry.contains(setting.Country__c)){
		        options.add(new SelectOption(setting.Country__c, setting.Country__c));
		        setUniqueCountry.add(setting.Country__c);
		    }
        options.sort();
        }
    return options;
    }


    /*Fetching cities based on country*/
    public void fetchCities(){
        City_List = new List<SelectOption>();
        for(TrainingData__City__c setting : TrainingData__City__c.getAll().values()) {
            if (setting.Country__c == this.Country) {
                City_List.add(new SelectOption(setting.name,setting.name));
            }
        }
    }
}