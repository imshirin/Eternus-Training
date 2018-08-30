public class SecondJob implements Queueable{
    Account a;
    public SecondJob(account param) {
        this.a = param;
    }
    public void execute(QueueableContext context) {
      system.debug('Second class  ====>'+[select id, name, phone from Account where id =: a.id]);
    }
}