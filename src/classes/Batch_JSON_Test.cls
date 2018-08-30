/*Test class for JSON object creation*/

@isTest
private class Batch_JSON_Test {
    /*Wrong JSON format*/
    static testMethod void bulkInvalidJSON() {
        String jsonField = '{"JSON":{"Name":"Eternus"}"Object Name":"Account"}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidJSON, event.error__c);
        }
    }

    static testMethod void bulkFieldEmpty() {
        String jsonField = '';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_FieldEmpty, event.error__c);
        }
    }

    static testMethod void bulkNoObject() {
        String jsonField = '{"JSON":{"Name":"Eternus"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoObjectName, event.error__c);
        }
    }

    static testMethod void bulkInvalidObjectName() {
        String jsonField = '{"JSON":{"Name":"Eternus"},"Object Name":"Account1"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidObjectName, event.error__c);
        }
    }

    static testMethod void bulkNoJSON() {
        String jsonField = '{"Object Name":"Account"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoJSON, event.error__c);
        }
    }

    static testMethod void bulkEmptyJSON() {
        String jsonField = '{"JSON":"","Object Name":"Account"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_NoJSON, event.error__c);
        }
    }

    static testMethod void bulkInvalidField() {
        String jsonField = '{"JSON":{"Name":"Eternus", "AccountNumber1":"11111"},"Object Name":"Account"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_InvalidField, event.error__c);
        }
    }

    static testMethod void bulkRequiredFieldNotProvided() {
        String jsonField = '{"JSON":{"AccountNumber":"11111"},"Object Name":"Account"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
            System.assertEquals(System.Label.Event_RequiredNotProvided, event.error__c);
        }
    }

    static testMethod void bulkSuccess() {
        String jsonField = '{"JSON":{"Name":"Eternus", "AccountNumber":"11111"},"Object Name":"Account"}}';
        Event_DataFactoty.createEvents(500, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b,500);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(true, event.IsProcessed__c);
            System.assertEquals(null, event.error__c);
        }
    }

    static testMethod void bulkException() {
        String jsonField = '{"JSON":{"Name":"Eternus", "Owner":"abcd"},"Object Name":"Account"}}';
        Event_DataFactoty.createEvents(100, jsonField);
        test.startTest();
            Batch_JSON b = new Batch_JSON();
            database.executeBatch(b);
        test.stopTest();
        List<Event__c> events = [Select IsProcessed__c, error__c from Event__c];
        for(Event__c event : events) {
            System.assertEquals(false, event.IsProcessed__c);
        }
    }
}