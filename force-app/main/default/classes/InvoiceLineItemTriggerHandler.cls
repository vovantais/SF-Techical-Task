public with sharing class InvoiceLineItemTriggerHandler {
  public static Boolean enablesTrigger = true;

  public static void handleAfterInsert(List<Invoice_Line_Item__c> invoiceLineItems) {
    if (invoiceLineItems != null && !invoiceLineItems.isEmpty()) {
      updateInvoiceField(invoiceLineItems);
    }
  }

  public static void handleAfterDelete(List<Invoice_Line_Item__c> invoiceLineItems) {
    if (invoiceLineItems != null && !invoiceLineItems.isEmpty()) {
      updateInvoiceField(invoiceLineItems);
    }
  }

  private static void updateInvoiceField(List<Invoice_Line_Item__c> invoiceLineItems) {
    Set<Id> invoiceIds = new Set<Id>();
    for (Invoice_Line_Item__c invoiceLineItem : invoiceLineItems) {
      invoiceIds.add(invoiceLineItem.Invoice__c);
    }

    List<Invoice__c> invoices = InvoiceLineItemTriggerManager.getInvoiceByIds(invoiceIds);
    if (invoices != null && !invoices.isEmpty()) {
      for (Invoice__c invoice : invoices) {
        invoice.Amount_of_line_items__c = invoice.Invoice_Line_Items__r.size();
      }
      update invoices;
    }
  }
}
