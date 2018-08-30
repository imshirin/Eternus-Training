/*Handler for JSON object creation*/

/*(converting provided field to lowercase bcoz getdescribe gives fields in
lowercase and we have to comapre provided field with that map)*/

public with sharing class Batch_JSON_Handler {
    public static void createRecordsBasedOnEvents(List<Event__c> events) {
        List<sObject> recordList = new List<sObject>();
        Set<String> recordFields;
        //map to store fields of sobject
        Map<String,Schema.SObjectField> allFieldsOfObject;
        for(Event__c event : events) {
            Boolean isValidField = true, containsRequiredFields = true;
            if(event.JSON__c != NULL) {
                try {
                    //deserialize json into string
                    Map<String, Object> jsonFieldMap = (Map<String, Object>)JSON.deserializeUntyped(event.JSON__c);
                    //get name of object into object name
                    String ObjectName = (String)jsonFieldMap.get('Object Name');
                    if(ObjectName != NULL) {
                        //If valid object
                        if(SObjectUtil.isObjectExist(ObjectName)) {
                            //if json is a key with value
                            if(jsonFieldMap.containsKey('JSON') && jsonFieldMap.get('JSON')!='') {
                                //serialize inner json 
                                String objectJson = JSON.serialize(jsonFieldMap.get('JSON'));
                                Map<String,String> jsonMap = (Map<String, String>)JSON.deserialize
                                                          (objectJson, Map<String, String>.class);
                                //getting all objects
                                Schema.SObjectType fetchedObjectType = Schema.getGlobalDescribe().get(ObjectName);
                                //creating record
                                sObject record = fetchedObjectType.newSObject();
                                //get all fields of that perticular object
                                allFieldsOfObject = fetchedObjectType.getDescribe().fields.getMap() ;
                                //Checking if object contains that field 
                                for(String fieldProvided: jsonMap.keySet()) {
                                    if(allFieldsOfObject.keySet().contains(fieldProvided.toLowerCase())) {
                                        record.put(fieldProvided.toLowerCase() ,jsonMap.get(fieldProvided));
                                    }
                                    //If not a field of object 
                                    else {
                                        isValidField = false;
                                        event.error__c = System.Label.Event_InvalidField;
                                        break;
                                    }
                                }
                                if(isValidField) {
                                    //creating record field set for storing all fields uniquely
                                    recordFields=new Set<String>();
                                    //adding field to set for inner json
                                    for(string fieldProvided : jsonMap.keySet()) {
                                        recordFields.add(fieldProvided.toLowerCase());
                                    }
                                    //checking whether field is required or not
                                    for(String field : allFieldsOfObject.keyset()) {
                                        Schema.DescribeFieldResult desribeResult =
                                        allFieldsOfObject.get(field).getDescribe();
                                        if( desribeResult.isCreateable() && !desribeResult.isNillable()
                                            && !desribeResult.isDefaultedOnCreate()) {
                                            //setting that field as not required
                                            if(!recordFields.contains(field.toLowerCase())) {
                                                containsRequiredFields = false;
                                                //Required field is not entered by third party
                                                event.error__c =
                                                System.Label.Event_RequiredNotProvided;
                                                break;
                                            }
                                        }
                                    }
                                    //adding record to list and mark isprocess as true
                                    if(containsRequiredFields) {
                                        recordList.add(record);
                                        event.IsProcessed__c = true;
                                    }
                                }
                            } else {
                                event.error__c = System.Label.Event_NoJSON;
                            }
                        } else {
                            event.error__c = System.Label.Event_InvalidObjectName;
                        }
                    } else {
                        event.error__c = System.Label.Event_NoObjectName;
                    }
                } catch(Exception e) {
                    event.error__c = System.Label.Event_InvalidJSON;
                }
            } else {
                event.error__c = System.Label.Event_FieldEmpty;
            }
        }
        try {
            insert recordList;
            update events;
        } catch(Exception e) {
            System.debug('ERROR::::::::' + e);
        }
    }
}