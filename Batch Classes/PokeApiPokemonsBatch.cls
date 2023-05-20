//Clase Batch 'PokeApiPokemonsBatch' que importa todos los Pokemons.//

global class PokeApiPokemonsBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    
    global List<Integer> start(Database.BatchableContext bc) {
        List<Integer> ids = new List<Integer>();
        for(Integer i=1; i<=898; i++){
            ids.add(i);
        }
        return ids;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> ids){
        List<Pokemon__c> pokes = new List<Pokemon__c>();
        for(Integer id : ids){
            
            pokes.add(PokeApiPokemons.getPokemon(id));
        }
        
        insert pokes;
    }
    
    global void finish(Database.BatchableContext bc){
        
        System.debug('Termino el batch');
    }
}