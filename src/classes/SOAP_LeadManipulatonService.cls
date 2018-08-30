/* An Apex SOAP web Service that will help external systems to manipulate Leads
within Salesforce */



global class SOAP_LeadManipulatonService {

    /*Inner class Response
     *where variables are declared to hold response
     */

    global class Response {
        webService Boolean isSuccess;
        webService Id leadId;
        WebService string status;
    }
    
    /* Method to create new Lead
     */
    webService static Response createLead (String firstName, String lastName, String company, String email, String phone) {
        try {
            lead record = new lead(firstName = firstName, lastName = lastName,  company = company, email = email, phone = phone);
            insert record;
            
            Response res = new Response();
            res.isSuccess = true;
            res.leadId = record.Id;
            res.status = 'success';
            return res;
        } catch (exception e) {
            Response res = new Response();
            res.isSuccess = false;
            res.leadId = null;
            res.status = e.getMessage();
            return res;
        }
    }
     
    /* Method to delete lead
     */
    webService static Response deleteLead (String firstName, String lastName, String email, String phone) {
        try {
            list<lead> lead_List = [select firstName, lastName, email, phone
            from lead where firstName =: firstName AND lastName =: lastName AND
            email =: email AND phone =: phone];
            delete lead_List;
            
            list<lead> leadData_List = new list<lead>();
            leadData_List.addAll(lead_List);
            Response res = new Response();
            res.isSuccess = true;
            res.leadId = leadData_List[0].Id;
            res.status = 'success';
            return res;
        } catch (exception e) {
            Response res = new Response();
            res.isSuccess = false;
            res.leadId = null;
            res.status = e.getMessage();
            return res;
        }
    }
    
    /* Method for updating lead
     */
    webService static Response updateLead (String firstName, String lastName, String email, String phone) {
        try {
            list<lead> lead_List = [select firstName, lastName, email, phone
            from lead where firstName =: firstName AND lastName =: lastName];
            for(lead record : lead_List) {
                record.email = 'newlead@test.com';
                record.phone = '99999995456';
            }
            update lead_List;
            
            Response res = new Response();
            res.isSuccess = true;
            res.leadId = lead_List[0].Id;
            res.status = 'success';
            return res;
             
        } catch (exception e) {
            Response res = new Response();
            res.isSuccess = false;
            res.leadId = null;
            res.status = e.getMessage();
            return res;
        }
    }
}