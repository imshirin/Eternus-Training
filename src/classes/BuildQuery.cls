public class BuildQuery {
    public List<SelectOption> selectedObject_List {set;get;}
    public List<SelectOption> fieldSelectedOptions{set;get;}
    public List<SelectOption> fieldsNotSelectedOptions{set;get;}
    public List<SelectOption> NumberOfRecordsOption {set;get;}
    public List<SelectOption> orderOptions{set;get;}

    public List<String> object_List {set;get;}
    public List<String> fields{set;get;}
    public List<String> queryFields{set;get;}
    public List<String> sfields{set;get;}
    public List<String> rfields{set;get;}
    public List<SObject> result{set;get;}

    public Set<String> fselected{set;get;}
    public Set<string> fnotselected{set;get;}

    public Map<String, Schema.SObjectField> map_Fields{set;get;}
    public Map<String, Schema.SObjectType> map_Object{set;get;}

    public String query{set;get;}
    public String objDescription {set;get;}
    public String selectedLimit {set;get;}
    public String selectedOrder{set;get;}
    public String selectedObj {set;get;}

    public Boolean isObjSelected{set;get;}
    public Boolean isQueryExecuted{set;get;}

    public integer countRecords {get; set;}


    public BuildQuery() {
        isObjSelected = false;
        isQueryExecuted = false;
        NumberOfRecordsOption = new List<SelectOption>();
        orderOptions = new List<SelectOption>();
        selectedObject_List = new List<SelectOption>();
        queryFields = new List<String>();
        object_List = new List<String>();
        result = new List<SObject>();
        sfields = new List<String>();
        rfields = new List<String>();
        fields = new List<String>();
        fselected = new Set<String>();
        fnotselected = new Set<String>();
        fieldSelectedOptions = new List<SelectOption>();
        fieldsNotSelectedOptions = new List<SelectOption>();
        
        /* fetching all objects */
        map_Object = Schema.getGlobalDescribe();
        
        /* finding which objects are accessible and queryable and storing them 
         * into object_List
         */
        for(Schema.SObjectType objToken : map_Object.values()) {
            Schema.DescribeSObjectResult objDescription = objToken.getDescribe();
            if (objDescription.isAccessible() && objDescription.isQueryable()){
                object_List.add(objDescription.getName());
            }
        }
        object_List.sort();
        
        /* Adding objects into picklist */
        SelectOption none = new SelectOption('None','-None-');
        selectedObject_List.add(none);
        for(String s : object_List)
        {
            SelectOption option = new SelectOption(s,s);
            selectedObject_List.add(option);
        }
        
        /* Adding different limits of records into picklist */
        NumberOfRecordsOption.add(new SelectOption('500','500'));
        NumberOfRecordsOption.add(new SelectOption('1000','1000'));
        NumberOfRecordsOption.add(new SelectOption('5000','5000'));
        NumberOfRecordsOption.add(new SelectOption('50000','50000'));
        selectedLimit = '500';
        
        /* Adding different order of records into picklist */
        orderOptions.add(new SelectOption('ASC','Ascending'));
        orderOptions.add(new SelectOption('DESC','Descending'));
        selectedOrder = 'ASC';
    }



    /* Method to select object from picklist and populated fields section with
     *fields available in selected object
     */
    public void accessFields() {
        isQueryExecuted = false;
        query = '';
        if(selectedObj != 'None') {
            /* fetching all fields of selected object into map_Fields */
            map_Fields = map_Object.get(selectedObj).getDescribe().fields.getMap();
            fields.clear();
            /* if field is accessible adding it into fields list*/
            for(Schema.SObjectField fieldToken : map_Fields.values()) {
                Schema.DescribeFieldResult fieldDescribe = fieldToken.getDescribe();
                if(fieldDescribe.isAccessible()) {
                    fields.add(fieldDescribe.getName());
                }
            }
            fields.sort();
            fnotselected.clear();
            fselected.clear();
            fnotselected.addAll(fields);
            isObjSelected = true;
            show();
        } 
        else {
            isObjSelected = false;
        }
    }
    
/*
* Method to add/remove fields from fields picklists as per the selected object and selected fields
*/
    public void show() {
        fieldsNotSelectedOptions.clear();
        fieldSelectedOptions.clear();
        for(String pickVal : fnotselected) {
            SelectOption op = new SelectOption(pickVal, pickVal);
            fieldsNotSelectedOptions.add(op);
        }
        for(String pickVal : fselected) {
            SelectOption op = new SelectOption(pickVal, pickVal);
            fieldSelectedOptions.add(op);
        }
    }
    
/*
* Method to add fields from fields picklists as per the selected object and selected fields
*/
    public void addFields() {
        fnotselected.removeAll(sfields);
        fselected.addAll(sfields);
        show();
    }
/*
* Method to remove fields from fields picklists as per the selected object and selected fields
*/
    public void removeFields() {
        System.debug('Rfields:::'+rfields);
        fnotselected.addAll(rfields);
        System.debug('fnotselected:::'+fnotselected);
        fselected.removeAll(rfields);
        show();
    }
    
/*
* Method to build and execute the query based on criteria selected by user
*/
    public void generateQuery() {
        queryFields.clear();
        queryFields.addAll(fselected);
        query = 'SELECT ';
        query += String.join(queryFields, ',');
        query += ' FROM '+ selectedObj +' ORDER BY Id '+selectedOrder+' LIMIT '+ selectedLimit;
        if(queryFields.size()>=1) {
            try {
                result = Database.query(query);
                countRecords = result.size();
                if(result.size()<1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No records'));
                }
                isQueryExecuted = true;
            }catch(Exception e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            }
        } 
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select fields to query'));
        }
        System.debug('query is:::'+query);
        System.debug('Data is:::'+result);
    }
    
    private void generateQueryClone() {

        System.debug('Rfields:::'+rfields);
        fnotselected.addAll(rfields);
        System.debug('fnotselected:::'+fnotselected);
        fselected.removeAll(rfields);
        show();
        queryFields.clear();
        queryFields.addAll(fselected);
        query = 'SELECT ';
        query += String.join(queryFields, ',');
        query += ' FROM '+ selectedObj +' ORDER BY Id '+selectedOrder+' LIMIT '+ selectedLimit;
        if(queryFields.size()>=1) {
            try {
                result = Database.query(query);
                countRecords = result.size();
                if(result.size()<1){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No records'));
                }
                isQueryExecuted = true;
            }catch(Exception e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            }
        } 
        else {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select fields to query'));
        }
        System.debug('query is:::'+query);
        System.debug('Data is:::'+result);
    }
}