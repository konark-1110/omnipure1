/*
public class OpportunityTriggerHandler {
     public static void createTaskOnOpportunity(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        List<Task> tasksToCreate = new List<Task>();

        for (Opportunity opp : newOpportunities) {
            if (opp.Sample_Requested__c && (Trigger.isInsert || (Trigger.isUpdate && oldOpportunities.get(opp.Id).Sample_Requested__c != opp.Sample_Requested__c))) {
                // Calculate due date as today + 30 days
                Date today = Date.today();
                Date dueDate = today.addDays(30);

                // Create a new task
                Task newTask = new Task(
                    WhatId = opp.Id,
                    Subject = 'Sample Follow Up',
                    ActivityDate = dueDate,
                    Status = 'Not Started',
                    Priority = 'Normal',
             		Title__c = 'Sample Requested'
                );
                // Add the task to the list
                tasksToCreate.add(newTask);
            }
        }
        insert tasksToCreate;
    }
}

*/


public class OpportunityTriggerHandler {
    public static void createTaskOnOpportunity(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        List<Task> tasksToCreate = new List<Task>();

        // Collect Opportunity IDs that meet the criteria
        Set<Id> opportunityIdsToProcess = new Set<Id>();
        for (Opportunity opp : newOpportunities) {
            
            if (opp.Sample_Requested__c && (Trigger.isInsert || (Trigger.isUpdate && oldOpportunities.containsKey(opp.Id) && oldOpportunities.get(opp.Id).Sample_Requested__c != opp.Sample_Requested__c))) {
                opportunityIdsToProcess.add(opp.Id);
            }
        }

        // Query the necessary information for the opportunities in bulk
        Map<Id, Opportunity> opportunitiesMap = new Map<Id, Opportunity>([SELECT Id, Sample_Requested__c FROM Opportunity WHERE Id IN :opportunityIdsToProcess]);

        // Calculate due date as today + 30 days
        Date today = Date.today();
        Date dueDate = today.addDays(30);

        // Create tasks in bulk
        for (Id oppId : opportunityIdsToProcess) {
            Opportunity opp = opportunitiesMap.get(oppId);

            // Check for null values before accessing fields
            if (opp != null) {
                // Create a new task
                Task newTask = new Task(
                    WhatId = opp.Id,
                    Subject = 'Sample Follow Up',
                    ActivityDate = dueDate,
                    Status = 'Not Started',
                    Priority = 'Normal',
                    Title__c = 'Sample Requested'
                );

                // Add the task to the list
                tasksToCreate.add(newTask);
            }
        }

        // Insert the tasks outside of the loop
        if (!tasksToCreate.isEmpty()) {
            insert tasksToCreate;
        }
    }
}