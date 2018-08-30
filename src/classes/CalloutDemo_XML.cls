public class CalloutDemo_XML {
	public String address{get;set;}
    public List<String> result{get; set;}

    public void makeCallout() {
        HTTP http = new HTTP();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('GET');
        req.setEndpoint('http://xml.utrace.de/?query='+address);
        res = http.send(req);
        result = parseResponse(res);
        System.debug('Result =======> '+result);
    }
    
    public List<String> parseResponse(HttpResponse res) {
        if(res.getStatusCode() == 200) {
            result = new List<String>();
            DOM.Document doc = new DOM.Document();
            doc = res.getBodyDocument();
            Dom.XmlNode root =  doc.getRootElement();
            Dom.XmlNode node = root.getChildElements()[0];
            for(Dom.XMLNode child : node.getChildElements()) {
                String abc = String.valueOf(child .getText());
				if(String.isNotBlank(abc))
	                result.add(abc);
			}
        }
        else {
            result = NULL;
        }
        return result;
    }
}