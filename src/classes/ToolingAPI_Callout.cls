/* 
 * Class for making callout to access property of Layout Tooling API object
 */

public with sharing class ToolingAPI_Callout {

    public static void getWithCallout() {

        list<string> field_Name_List = new list<string> ();
        list<string> field_Requied_List = new list<string> ();
        list<string> field_ReadOnly_List = new list<string> ();
        list<string> field_Edit_List = new list<string> ();

        Http httpObj = new Http();
        HttpRequest request = new HttpRequest();

        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        request.setHeader('Content-Type', 'application/json');

        String domainUrl=URL.getSalesforceBaseUrl().toExternalForm();

        request.setEndpoint(domainUrl+'/services/data/v39.0/tooling/query/?q='+
                            'SELECT+EntityDefinitionId,FullName,LayoutType,'+
                            'ManageableState,Name,NamespacePrefix,'+
                            'ShowSubmitAndAttachButton,TableEnumOrId,metadata+'+
                            'FROM+Layout+where+id=\'00h7F000001MHzW\'');
        request.setMethod('GET');

        try{
             HttpResponse response = httpObj.send(request);
             if(response.getStatusCode() == 200) {

                /* Deserializing response which return output in the form of map */
                Map<String, Object> responseJsonMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody()); System.debug('++++++++++++++++++++'+response.getBody());

                if(!responseJsonMap.isEmpty()) {
                    /* Accessing list of records */
                    List<object> recordsList = (List<object>)responseJsonMap.get('records');

                    if(!recordsList.isEmpty()) {
                        /* Fetching first map of record */
                        Map<String,Object> fieldOnLayoutMap = (Map<String,Object>)recordsList[0];

                        if(!fieldOnLayoutMap.isEmpty()) {
                            /* Fetching name of layout */
                            System.debug('\n\n-----------Layout name------------\n'+(object)(fieldOnLayoutMap.get('FullName'))); 

                            /* Accessing metadata of layout */
                            Map<String,Object> metaDataMap = (Map<String,Object>)fieldOnLayoutMap.get('Metadata');
                            

                            if(!metaDataMap.isEmpty()) {
                                /* Fetching list of sections of layout */
                                list<Object> layoutSectionList = (list<Object>)metaDataMap.get('layoutSections');
                
                                if(!layoutSectionList.isEmpty()) {
                                    /* Accessing individual section which contains layoutItems */
                                    Map<String,Object> selectedSectionMap = (Map<String,Object>)layoutSectionList[0];
                
                                    if(!selectedSectionMap.isEmpty()) {
                                        /* Fetching list of columns available in page layout section */
                                        list<Object> layoutColumnList = (list<Object>)selectedSectionMap.get('layoutColumns');

                                        if(!layoutColumnList.isEmpty()) {
                                            /* Iterating more than one columns of section*/
                                            for(Object outerObj : layoutColumnList) {
                    
                                                /* Accessing individual column and its data */
                                                Map<String,Object> singleColumnMap = (Map<String,Object>)outerObj;
                    
                                                if(!singleColumnMap.isEmpty()) {
                                                    /* Fetching layout Items available on perticular column of section*/
                                                    list<Object> layoutItemsList = (list<Object>)singleColumnMap.get('layoutItems');

                                                    if(!layoutItemsList.isEmpty()) {
                                                        /* Iterating list of Layout Item*/
                                                        for(Object innerObj : layoutItemsList) {
                        
                                                            /* Accessing properties of individual Item */
                                                            Map<String,Object> PropertyMap = (Map<String,Object>)innerObj;
                        
                                                            if(!PropertyMap.isEmpty()) {
                                                                /* storing all fields available on page layout */
                                                                field_Name_List.add((string)PropertyMap.get('field'));
                                                                string temp = null;
                        
                                                                /* Fetching behavior property of field */
                                                                temp = (string)PropertyMap.get('behavior');

                                                                /* Adding fields according to its behaviour seperately */
                                                                if(temp == 'Readonly') {
                                                                    field_ReadOnly_List.add((string)PropertyMap.get('field'));
                                                                }
                                                                else if(temp == 'Required') {
                                                                    field_Requied_List.add((string)PropertyMap.get('field'));
                                                                }
                                                                else if(temp == 'Edit') {
                                                                    field_Edit_List.add((string)PropertyMap.get('field'));
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            // Fetching custom buttons
                            list<Object> button_Lst = (list<Object>)metaDataMap.get('customButtons');
                            System.debug('************* Custom Buttons'+button_Lst);
                        }
                    }
                }
                System.debug('\n\n-----------Fields name------------');
                for(object fieldObj : field_Name_List) {
                    System.debug(fieldObj);
                }
                
                System.debug('\n\n-----------Read only--------------');
                for(object readOnlyObj : field_ReadOnly_List) {
                    System.debug(readOnlyObj);
                }
                
                System.debug('\n\n-----------Requird----------------');
                for(object reqObj : field_Requied_List) {
                    System.debug(reqObj);
                }
                
                System.debug('\n\n-----------Editable---------------');
                for(object editObj : field_Edit_List) {
                    System.debug(editObj);
                }
                }
             }catch(System.CalloutException exp) {
        System.debug('\n\nException: '+exp);
        }
    }
}