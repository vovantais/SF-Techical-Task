@IsTest
private with sharing class InvoiceLineItemTriggerManagerTest {

    @TestSetup
    private static void initTestData() {
        InvoiceLineItemTriggerTestDataFactory.initializeTestData();
    }

    @IsTest
    private static void getInvoiceByIdsTest_Positive() {
        List<Invoice__c> invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();
        Set<Id> invoiceIds = new Set<Id>();
        for (Invoice__c invoice : invoices) {
            invoiceIds.add(invoice.Id);
        }
        List<Invoice__c> listInvoices = InvoiceLineItemTriggerManager.getInvoiceByIds(invoiceIds);

        Assert.isNotNull(listInvoices);
        Assert.areEqual(2, listInvoices.size());
    }

    @IsTest
    private static void getInvoiceByIdsTest_Negative() {
        Assert.isNull(InvoiceLineItemTriggerManager.getInvoiceByIds(null));
    }
}