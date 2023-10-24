global with sharing class ValidateDefinitionOfDone implements copadoAiHelper.Action.Actionable {
    global List<String> appliesTo() {
        return new List<String> {'User_Story'};
    } 
    
    global String jsonSchema() {
        return '{'+
            '    "name": "definition_of_done",'+
            '    "description": "definition of done",'+
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
        String title = (String)args?.get('title');
        String project = (String)args?.get('project');
        String team = (String)args?.get('team');
        
        if(String.isNotBlank(title) && String.isNotBlank(project) && String.isNotBlank(team)) {
            return new copadoAiHelper.ActionResponse('Your definition of done is complete');
        } else {
            return new copadoAiHelper.ActionResponse('You have some incomplete fields, should we update the user story with the missing information ?');
        }
    }
}