//Clase 'PokeApiAbilities' que trae la información de las Habilidades de los Pokemons.//

public with sharing class PokeApiAbilities {
	public static final String URL = 'https://pokeapi.co/api/v2/ability/';
    
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
    
    public static Habilidad__c getAbility (Integer id) {
        HttpResponse response = PokeApiAbilities.getResponse(id);
        Habilidad__c ability = new Habilidad__c();
        
        if(response.getStatusCode() == 200){
            PokeApiWrapperAbility responseWrapper = PokeApiWrapperAbility.parse(response.getBody());
            	String nameCap = responseWrapper.name;
                ability.Name = nameCap.capitalize();
            	ability.ExtId__c = responseWrapper.id;
            
            if((responseWrapper.effect_entries != null) && (!responseWrapper.effect_entries.isEmpty())){
                    
                    for(Integer i=0; i<responseWrapper.effect_entries.size(); i++){
                        Effect_entries_Z effect = responseWrapper.effect_entries.get(i);
                        
                        if(effect.language.name == 'en'){
                            ability.Effect_Entries_short_effect__c = effect.short_effect;
                        }
                    }
            }
            
        }
        
        return ability;
        
    }
    
    public class Language {
		public String name;
		public String url;
	}
    
    public class Effect_entries_Z {
		public String effect;
		public Language language;
		public String short_effect;
	}

	public class Effect_entries {
		public String effect;
		public Language language;
	}
    
    public class PokeApiWrapperAbility {
        public String name;
        public Integer id;
        public List<Effect_entries_Z> effect_entries;
        
    }
    
    public static PokeApiWrapperAbility parse(String json) {
		return (PokeApiWrapperAbility) System.JSON.deserialize(json, PokeApiWrapperAbility.class);
	}
}