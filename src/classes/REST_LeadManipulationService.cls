@RestResource(urlMapping = '/LeadMapping/*' )
global class REST_LeadManipulationService {
    
   
      @HttpPost
      
    global static void doPost(string FName, String LName, string EmailId,  string PhoneNo, string company) {
        lead record = new lead();
        try {
            record.FirstName = FName;
            record.LastName = LName;
            record.Email = EmailId;
            record.Phone = PhoneNo;
            record.company = company;
            insert record;
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody =
            Blob.valueOf('{"isSucess" : "true", "Lead" : "'
            + FName +' '+ LName +'", "status" : "success"}');
        }
        catch(exception e) {
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = 
            Blob.valueOf('{ "Lead " : " ", "isSuccess " : "False", "Status " : "'+ e.getMessage() +'"}');
        }
    }
    
     @HttpDelete
    global static void doDelete () {
        try {
	        RestRequest req = RestContext.request;
	        RestResponse res = RestContext.response;
            string FName = req.params.get('FName');
            string LName = req.params.get('LName');
            string EmailId = req.params.get('EmailId');
            string PhoneNo = req.params.get('PhoneNo');
            
            lead result= [select firstname, lastname from lead where
            FirstName =: FName AND LastName =: LName AND Email =: EmailId
            AND phone =: PhoneNo];

	            delete result;
	            RestContext.response.addHeader('Content-Type', 'application/json');
		        RestContext.response.responseBody = 
		        Blob.valueOf('{"isSucess" : "true", "Lead" : "'
	            + FName +' '+ LName +'", "status" : "success"}');
        }
        catch(exception e) {
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = 
            Blob.valueOf('{ "Lead " : " ", "isSuccess " : "False", "Status " : "'+ e.getMessage() +'"}');
        }
    }
    
    
    
    
    @HttpPatch
    global static void doUpdate (string FName, String LName, string EmailId, string PhoneNo) {
        try {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            list<lead> updated_List = new list<lead> ();
            lead record = [select email, phone from lead where FirstName =: FName AND
            LastName =: LName];
            record.phone = PhoneNo;
            record.email = EmailId;
            update record;
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = 
            Blob.valueOf('{"isSucess" : "true", "Lead" : "'
            + FName +' '+ LName +'", "status" : "success"}');
        }
        catch(exception e) {
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.responseBody = 
            Blob.valueOf('{ "Lead " : " ", "isSuccess " : "False", "Status " : "'+ e.getMessage() +'"}');
        }
    }
}