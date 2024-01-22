public class LeadTriggerHandler {
    public static void updateLeadSource(List<Lead> newLeads){
        for(Lead leadRecord:newLeads){
            if(leadRecord.Lead_from_Web__c==true){
                leadRecord.LeadSource='Websiste';
            }
        }
    }
    
    public static void tickCheckboxForEndUser(List<Lead> newLeads){
        for(Lead leadRecord:newLeads){
            if(leadRecord.Lead_Type__c.contains('End User')){
                leadRecord.Distributor_Lead__c=true;
            }
                else{
                leadRecord.Distributor_Lead__c=false;
        }
            
    }
        
    }
    
}		

/*
public class LeadTriggerHandler {

    public static void updateLeadSource(List<Lead> newLeads) {
        List<Lead> leadsToUpdate = new List<Lead>();

        for (Lead leadRecord : newLeads) {
            if (leadRecord.Lead_from_Web__c == true) {
                leadsToUpdate.add(new Lead(Id = leadRecord.Id, LeadSource = 'Website'));
            }
        }

        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }

    public static void tickCheckboxForEndUser(List<Lead> newLeads) {
        List<Lead> leadsToUpdate = new List<Lead>();

        for (Lead leadRecord : newLeads) {
            if (leadRecord.Lead_Type__c != null && leadRecord.Lead_Type__c.contains('End User')) {
                leadsToUpdate.add(new Lead(Id = leadRecord.Id, Distributor_Lead__c = true));
            } else {
                leadsToUpdate.add(new Lead(Id = leadRecord.Id, Distributor_Lead__c = false));
            }
        }

        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}
		*/