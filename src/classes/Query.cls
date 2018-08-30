public with sharing class Query {
    public list<selectOption> objects {get;set;}
    public list<SelectOption> fSelectedtOptions {get; set;}
    public list<SelectOption> fNotSelectedOptions {get; set;}
    public list<string> objList {get;set;}
    public list<string> fieldsList {get; set;}
    public list<string> sfields {get; set;}
    public list<string> rfields {get; set;}
    public set<string> fSelected {get; set;}
    public set<string> fNotSelected {get; set;}
    public map<string, schema.SObjectField> map_Fields;
    public map<string, schema.sObjectType> map_Object{get;set;}
    public string selectedObj {get; set;}
    public string objDescription {get; set;}
    
    public Query () {
        objects = new list<SelectOption> ();
        fSelectedtOptions =  new list<SelectOption> ();
        fNotSelectedOptions =  new list<SelectOption> ();
        objList = new list<string> ();
        fieldsList = new list<string> ();
        sfields = new list<string>();
        rfields = new list<string>();
        fSelected = new set<string> ();
        fNotSelected = new set<string> ();
        
        map_Object = Schema.getGlobalDescribe ();

       /*sorting objects for picklist*/
        objList.addAll (map_Object.keySet());
        objList.sort ();    
        
        SelectOption noneOp = new SelectOption ('none', '-None-');
         objects.add (noneOp);
            
        /*adding objects to picklist*/ 
        for(string pickVal : objList){
            SelectOption op = new SelectOption (pickVal, pickVal);
            objects.add (op);
        }
    }
    
    public void accessFields() {
        schema.DescribeSObjectResult myObj = map_Object.get(selectedObj).getDescribe();
        objDescription = ' '+myObj;
        
        map_Fields = map_Object.get(selectedObj).getDescribe().fields.getMap();
        fieldsList.addAll(map_Fields.keySet());
        fieldsList.sort();
        fNotSelected.addAll(fieldsList);
        show();
    }
    
    public void show() {
        fNotSelectedOptions.clear();
        for(string str : fNotSelected) {
            SelectOption op = new SelectOption(str, str);
            fNotSelectedOptions.add(op);
        }
    }
}