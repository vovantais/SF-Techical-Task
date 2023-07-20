trigger InvoiceLineItemTrigger on Invoice_Line_Item__c(after insert, after delete) {
  if (InvoiceLineItemTriggerHandler.enablesTrigger) {
    if (Trigger.isAfter) {
      if (Trigger.isInsert) {
        InvoiceLineItemTriggerHandler.handleAfterInsert(Trigger.new);
      } else if (Trigger.isDelete) {
        InvoiceLineItemTriggerHandler.handleAfterDelete(Trigger.old);
      }
    }
  }
}
