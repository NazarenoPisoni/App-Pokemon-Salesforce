//Clase Batch 'PokeApiAbilitiesBatch' que importa todas las Habilidades.//

global class PokeApiAbilitiesBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    
    global List<Integer> start(Database.BatchableContext bc) {
        List<Integer> ids = new List<Integer>();
        for(Integer i=1; i<=267; i++){
            ids.add(i);
        }
        return ids;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> ids){
        List<Habilidad__c> abilities = new List<Habilidad__c>();
        for(Integer id : ids){
            
            abilities.add(PokeApiAbilities.getAbility(id));
        }
        
        insert abilities;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Termino el batch');
    }
}