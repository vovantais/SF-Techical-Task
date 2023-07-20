@IsTest
private with sharing class InvoiceLineItemTriggerHandlerTest {

  @IsTest
  private static void handleAfterInsertTest_Positive() {
    Invoice__c invoice = InvoiceLineItemTriggerTestDataFactory.createInvoice('invoice');
    insert invoice;

    Invoice_Line_Item__c firstInvoiceLineItem = InvoiceLineItemTriggerTestDataFactory.createInvoiceLineItem(
      'firstInvoiceLineItem',
      invoice.Id
    );
    insert firstInvoiceLineItem;

    InvoiceLineItemTriggerHandler.handleAfterInsert(
      new List<Invoice_Line_Item__c>{ firstInvoiceLineItem }
    );
    List<Invoice__c> invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();

    Assert.areEqual(1, invoices[0].Amount_of_line_items__c);

    Invoice_Line_Item__c secondInvoiceLineItem = InvoiceLineItemTriggerTestDataFactory.createInvoiceLineItem(
      'secondInvoiceLineItem',
      invoice.Id
    );
    insert secondInvoiceLineItem;

    InvoiceLineItemTriggerHandler.handleAfterInsert(
      new List<Invoice_Line_Item__c>{ secondInvoiceLineItem }
    );
    invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();

    Assert.areEqual(2, invoices[0].Amount_of_line_items__c);
  }

  @IsTest
  private static void handleAfterInsertTest_Negative() {
    InvoiceLineItemTriggerHandler.handleAfterInsert(new List<Invoice_Line_Item__c>());
    List<Invoice__c> invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();

    Assert.areEqual(0, invoices.size());
  }

  @IsTest
  private static void handleAfterDeleteTest_Positive() {
    Invoice__c invoice = InvoiceLineItemTriggerTestDataFactory.createInvoice(
      'invoice'
    );
    insert invoice;

    Invoice_Line_Item__c firstInvoiceLineItem = InvoiceLineItemTriggerTestDataFactory.createInvoiceLineItem(
      'firstInvoiceLineItem',
      invoice.Id
    );

    Invoice_Line_Item__c secondInvoiceLineItem = InvoiceLineItemTriggerTestDataFactory.createInvoiceLineItem(
      'secondInvoiceLineItem',
      invoice.Id
    );
    insert new List<SObject>{ firstInvoiceLineItem, secondInvoiceLineItem };

    List<Invoice_Line_Item__c> invoiceLineItems = InvoiceLineItemTriggerTestDataFactory.getInvoiceLineItems();
    Assert.areEqual(2, invoiceLineItems.size());

    delete invoiceLineItems;

    InvoiceLineItemTriggerHandler.handleAfterDelete(invoiceLineItems);
    List<Invoice__c> invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();
    invoiceLineItems = InvoiceLineItemTriggerTestDataFactory.getInvoiceLineItems();

    Assert.areEqual(0, invoiceLineItems.size());
    Assert.areEqual(0, invoices[0].Amount_of_line_items__c);
  }

  @IsTest
  private static void handleAfterDeleteTest_Negative() {
    InvoiceLineItemTriggerHandler.handleAfterDelete(new List<Invoice_Line_Item__c>());
    List<Invoice__c> invoices = InvoiceLineItemTriggerTestDataFactory.getInvoices();

    Assert.areEqual(0, invoices.size());
  }
}
