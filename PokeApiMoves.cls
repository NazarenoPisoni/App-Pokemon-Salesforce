//Clase 'PokeApiMoves' que trae la información de los Movimientos de los Pokemons.//

public with sharing class PokeApiMoves {
    
    public static final String URL = 'https://pokeapi.co/api/v2/move/';

    public static HttpResponse getResponse (Integer id){
        	HttpResponse respuesta;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL + id);
            request.setMethod('GET');
        	request.setHeader('Content-Type', 'application/json');
            HttpResponse response = http.send(request);
            
            return response;
    }
    
    public static Movimiento__c getMove (Integer id){
        HttpResponse response = PokeApiMoves.getResponse(id);
        Movimiento__c move = new Movimiento__c();
        
        if(response.getStatusCode() == 200){
            PokeApiWrapper responseWrapper = PokeApiWrapper.parse(response.getBody());
                
                move.Accuracy__c = responseWrapper.accuracy;
                move.Effect_chance__c = (Integer) responseWrapper.effect_chance;
                move.ExtId__c = responseWrapper.id;
                String nameCap = responseWrapper.name;
                move.Name = nameCap.capitalize();
                move.Power__c = responseWrapper.power;
                move.Pp__c = responseWrapper.pp;
                move.Priority__c = responseWrapper.priority;
                move.Target_name__c = responseWrapper.target.name;
                move.Type__c = responseWrapper.type.name;
            
                if((responseWrapper.effect_entries != null) && (!responseWrapper.effect_entries.isEmpty())){
                    for(Integer i=0; i<responseWrapper.effect_entries.size(); i++){
                        Effect_entries effect = responseWrapper.effect_entries.get(i);
                        move.Effect_Entries_short_effect__c = effect.short_effect;
                        
                    }
                }
            }
        
        return move;
    }
    
    public class Language {
            public String name;
            public String url;
        }
    
    public class Effect_entries {
            public String effect;
            public Language language;
            public String short_effect;
        }
    
    public class Target {
            public String name;
        	public String url;
        }
    
    public class Type {
            public String name;
        	public String url;
        }

    public class PokeApiWrapper {
    
        public Integer accuracy;
        public String name;
        public Integer effect_chance;
        public List<Effect_entries> effect_entries;
        public Integer id;
        public Integer power;
        public Integer pp;
        public Integer priority;
        public Target target;
        public Type type;
    
	}
    
    public static PokeApiWrapper parse(String json) {
            return (PokeApiWrapper) System.JSON.deserialize(json, PokeApiWrapper.class);
    }
}