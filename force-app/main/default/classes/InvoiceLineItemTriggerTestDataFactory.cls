@IsTest
public with sharing class InvoiceLineItemTriggerTestDataFactory {

  public static void initializeTestData() {
    Invoice__c firstInvoice = createInvoice('firstInvoice');
    Invoice__c secondInvoice = createInvoice('firstInvoice');

    insert new List<SObject>{ firstInvoice, secondInvoice };

    Invoice_Line_Item__c firstInvoiceLineItem = createInvoiceLineItem(
      'firstInvoiceLineItem',
      firstInvoice.Id
    );
    Invoice_Line_Item__c secondInvoiceLineItem = createInvoiceLineItem(
      'secondInvoiceLineItem',
      firstInvoice.Id
    );
    Invoice_Line_Item__c thirdInvoiceLineItem = createInvoiceLineItem(
      'firstInvoiceLineItem',
      secondInvoice.Id
    );

    insert new List<SObject>{
      firstInvoiceLineItem,
      secondInvoiceLineItem,
      thirdInvoiceLineItem
    };
  }

  public static Invoice__c createInvoice(String name) {
    return new Invoice__c(Name = name, Amount_of_line_items__c = 0);
  }

  public static Invoice_Line_Item__c createInvoiceLineItem(String name, String invoiceId) {
    return new Invoice_Line_Item__c(Name = name, Invoice__c = invoiceId);
  }

  public static List<Invoice__c> getInvoices() {
    return [SELECT Id, Amount_of_line_items__c FROM Invoice__c];
  }

  public static List<Invoice_Line_Item__c> getInvoiceLineItems() {
    return [SELECT Id, Invoice__c FROM Invoice_Line_Item__c];
  }
}
