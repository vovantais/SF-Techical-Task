public with sharing class InvoiceLineItemTriggerManager {

  public static List<Invoice__c> getInvoiceByIds(Set<Id> invoiceIds) {
    if (invoiceIds != null) {
      return [
        SELECT
          Id,
          Amount_of_line_items__c,
          (SELECT Id FROM Invoice_Line_Items__r)
        FROM Invoice__c
        WHERE Id IN :invoiceIds
      ];
    }
    return null;
  }
}
