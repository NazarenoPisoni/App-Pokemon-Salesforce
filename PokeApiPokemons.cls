//Clase 'PokeApiPokemons' que trae la información de los Pokemons.//

public class PokeApiPokemons {
	public static final String URL = 'https://pokeapi.co/api/v2/pokemon/';
    
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
    
    public static Pokemon__c getPokemon (Integer id) {
        HttpResponse response = PokeApiPokemons.getResponse(id);
        Pokemon__c poke = new Pokemon__c();
        Habilidad__c habi = new Habilidad__c();
        Movimiento__c move1 = new Movimiento__c();
        Movimiento__c move2 = new Movimiento__c();
        Movimiento__c move3 = new Movimiento__c();
        Movimiento__c move4 = new Movimiento__c();
        
        if(response.getStatusCode() == 200){
            PokeApiWrapperPokemon responseWrapper = PokeApiWrapperPokemon.parse(response.getBody());
            poke.ExtId__c = responseWrapper.id;
            poke.Height__c = responseWrapper.height;
            poke.Image__c = responseWrapper.sprites.front_default;
            String nameCap = responseWrapper.name.capitalize();
            poke.Name = nameCap;
            poke.Weight__c = responseWrapper.weight;
            
            if(responseWrapper.moves[0] != null){
                Moves moves = responseWrapper.moves.get(0);
                move1 = [SELECT Id, Name FROM Movimiento__c WHERE Name = :moves.move.name.capitalize()];
                poke.Slot1__c = move1.Id;
            }
            
            if(responseWrapper.moves[1] != null){
                	Moves moves = responseWrapper.moves.get(1);
                	move2 = [SELECT Id, Name FROM Movimiento__c WHERE Name = :moves.move.name.capitalize()];
                	poke.Slot2__c = move2.Id;
           	}
            
            if(responseWrapper.moves[2] != null){
                	Moves moves = responseWrapper.moves.get(2);
                	move3 = [SELECT Id, Name FROM Movimiento__c WHERE Name = :moves.move.name.capitalize()];
                	poke.Slot3__c = move3.Id;
           	}
            
            if(responseWrapper.moves[3] != null){
                	Moves moves = responseWrapper.moves.get(3);
                	move4 = [SELECT Id, Name FROM Movimiento__c WHERE Name = :moves.move.name.capitalize()];
                	poke.Slot4__c = move4.Id;
           	}
            
            if((responseWrapper.abilities != null) && (!responseWrapper.abilities.isEmpty())){
            	Abilities abilities = responseWrapper.abilities.get(0);
                habi = [SELECT Id, Name FROM Habilidad__c WHERE Name = :abilities.ability.name.capitalize()];
                poke.Habilidad__c = habi.Id;
            }
            
            if((responseWrapper.stats != null) && (!responseWrapper.stats.isEmpty())){
                for(Integer i=0; i<responseWrapper.stats.size(); i++){
                    if(responseWrapper.stats[i].stat.name == 'hp'){
                        poke.Stats_hp__c = responseWrapper.stats[i].base_stat;
                 	}
                    if(responseWrapper.stats[i].stat.name == 'attack'){
                        poke.Stats_attack__c = responseWrapper.stats[i].base_stat;
                    }    
                    if(responseWrapper.stats[i].stat.name == 'defense'){
						poke.Stats_defense__c = responseWrapper.stats[i].base_stat;
                    }
                    if(responseWrapper.stats[i].stat.name == 'speed'){
                    	poke.Stats_speed__c = responseWrapper.stats[i].base_stat;
                    }   
                }
          	}
            
            if((responseWrapper.types != null) && (!responseWrapper.types.isEmpty())){
                String values = ' ; ';
                for(Integer i=0; i<responseWrapper.types.size(); i++){
                        values += responseWrapper.types[i].type.name + ' ; ';
                }    
                poke.Types__c = values;
            }
        }
        
        return poke;
    }
    
    public class Ability {
        public String name;
        public String url;
    }
    
    public class Abilities {
    	public Ability ability;
        public Boolean is_hidden;
        public Integer slot;
    }
    
    public class Sprites {
        public String back_default;
        public String back_female;
        public String back_shiny;
        public String back_shiny_female;
        public String front_default;
        public String front_female;
        public String front_shiny;
        public String front_shiny_female;
    }
    
    public class Move {
        public String name;
        public String url;
    }
    
    public class Moves {
        public Move move;
    }
    
    public class Stat {
        public String name;
        public String url;
    }
    
    public class Stats {
        public Integer base_stat;
        public Integer effort;
        public Stat stat;
    }
    
    public class Type {
        public String name;
        public String url;
    }
    
    public class Types {
        public Integer slot;
        public Type type;
    }
    
    public class PokeApiWrapperPokemon {
    	public Integer id;
        public List<Abilities> abilities;
        public Integer height;
        public Sprites sprites;
        public String name;
        public List<Moves> moves;
        public List<Stats> stats;
        public List<Types> types;
        public Integer weight;
        
    }
    
    public static PokeApiWrapperPokemon parse(String json) {
			return (PokeApiWrapperPokemon) System.JSON.deserialize(json, PokeApiWrapperPokemon.class);
	}
}