public class ControllerClass {
@auraEnabled
    public static list<account> getAccount() {
        return[select name from Account];
    }
  }