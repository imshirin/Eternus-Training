public class ContactController {
    @auraEnabled
    public static List<Contact> findAll() {
        return([select Id, name, phone from Contact Limit 50]);
    }
    
    @auraEnabled
    public static List<Contact> findByName(String name) {
        return([select Id, name, phone from Contact where name like '%name%'Limit 50]);
    }
    
    @auraEnabled
    public static List<Contact> findById(Id conId) {
        return([select Id, name, phone from Contact where Id =: conId Limit 50]);
    }
    
}