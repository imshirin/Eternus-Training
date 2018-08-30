/*Handler for Batch_ClosedWonOpportunity*/


public with sharing class Batch_ClosedWonOpportunity_Handler {
    public static string queryMethod() {
        return ('Select(Select Name, StageName, Amount, CloseDate From '+
        'Opportunities where StageName= \'Closed Won\' and CloseDate  = today),'+
        '(Select contact.email, IsPrimary From AccountContactRoles where IsPrimary = true)'+
        'From Account where id in'+
        '(select accountid from opportunity where StageName= \'Closed Won\'AND CloseDate =today)'+
        'AND id in(select accountid from AccountContactRole where isprimary = true)');
    }
    
    
    public static map<string,Map<String, List<opportunity>>> methodExecute(list<account> acc_List,  Map<string,Map<String,List<Opportunity>>> mapObj) {
        for(account acc : acc_List) {
             if(!mapObj.containsKey(acc.Id)) {
                 mapObj.put(acc.Id, new map<string, list<opportunity>>());
             }
             mapObj.get(acc.Id).put(acc.AccountContactRoles[0].contact.email,acc.opportunities);
         }
         return mapObj;
    }
    
    
    public static void finishMethod( Map<string,Map<String,List<Opportunity>>> mapObj) {
        Boolean isMailIdNull = false;
        String mailBody='';
        String[] mailAddress=new String[]{};
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        for(String Id : mapObj.keySet()){
            isMailIdNull = false;
            mailBody = '';
            double sum;
            mailAddress.clear();
            for(String MailId : mapObj.get(Id).keySet()){
                if(MailId != null){
                    mailAddress.add(MailId);
                    for(Opportunity opp : mapObj.get(Id).get(MailId)){
                        if(opp.name != null && opp.amount != null) {
                            mailBody += 'Opportunity:::'+opp.Name+'\n';
                            mailBody += 'Amount:::'+opp.Amount+'\n';
                            sum = sum + opp.amount;
                        }
                    }
                    mailBody += 'Aggregate = '+ sum + '\n\n\n';
                    mailBody += 'Thank You';
                }else{
                    isMailIdNull = true;
                }
            }
            if(!isMailIdNull){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(mailAddress);
                mail.setSubject('Analisys of closed-won Opportunity');
                mail.setPlainTextBody(mailBody);
                listMail.add(mail);
            }
        }
        //Messaging.sendEmail(listMail);
    }
}