public class AsyncExecutionExample implements Queueable {
    public void execute(QueueableContext context) {
        Account a = new Account(Name='shirin testing here',Phone='(415) 555-1212');
        insert a;
        system.debug('First class ====== ');
        System.enqueueJob(new SecondJob(a));
    }
}