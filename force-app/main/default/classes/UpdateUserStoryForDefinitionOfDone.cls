global with sharing class UpdateUserStoryForDefinitionOfDone implements copadoAiHelper.Action.Actionable {
    global List<String> appliesTo() {
        return new List<String> {'User_Story'};
    } 
    
    global String jsonSchema() {
        return '{'+
            '    "name": "update_the_user_story",'+
            '    "description": "update the user story",'+
            '    "examples": [],'+
            '    "parameters": {'+
            '        "type": "object",'+
            '        "properties": {'+
            '            "title": {"type": "string", "description": "The title of the US"},'+
            '            "project": {"type": "string", "description": "The project of the US"},'+
            '            "team": {"type": "string", "description": "The team of the US"}'+
            '        }'+
                '}'+
            '}';
    }
    

    global copadoAiHelper.ActionResponse call(Id contextId, Map<String, Object> args) {
        // This parameter is automatically added. It might be null if the action is not for specific objects.
        String copadoContextId = (String)args.get('copadoContextId');
        String title = (String)args.get('title');
        String project = (String)args.get('project');
        String team = (String)args.get('team');
        copado__User_Story__c usr = [SELECT Id FROM copado__User_Story__c WHERE Id =: contextId];  
        
        /* 
            For demo purpose we are setting any values to the empty fields which makes the definition of done
            We can also configure this based on the user response
        */ 
        if(String.isBlank(title)) {
            usr.copado__User_Story_Title__c = 'Test';
        }

        if(String.isBlank(project)) {
            List<copado__Project__c> projects = [SELECT Id FROM copado__Project__c LIMIT 1];
            usr.copado__Project__c = projects[0].Id;
        }

        if(String.isBlank(team)) {
            List<copado__Team__c> teams = [SELECT Id FROM copado__Team__c LIMIT 1];
            usr.copado__Team__c = teams[0].Id;
        }

        if(String.isBlank(title) || String.isBlank(project) || String.isBlank(team)) {
            update usr;
            return new copadoAiHelper.ActionResponse('We have updated the user story and your definition of done is complete');
        } else {
            return new copadoAiHelper.ActionResponse('Your definition of done is complete');
        }
    }
}