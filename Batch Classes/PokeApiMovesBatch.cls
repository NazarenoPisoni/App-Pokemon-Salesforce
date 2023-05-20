//Clase Batch 'PokeApiMovesBatch' que importa todos los Movimientos.//

global class PokeApiMovesBatch implements Database.Batchable<Integer>, Database.Stateful, Database.AllowsCallouts {
    
    global List<Integer> start(Database.BatchableContext bc) {
        List<Integer> ids = new List<Integer>();
        for(Integer i=1; i<=826; i++){
            ids.add(i);
        }
        return ids;
    }
    
    global void execute(Database.BatchableContext bc, List<Integer> ids){
        List<Movimiento__c> moves = new List<Movimiento__c>();
        for(Integer id : ids){
            
            moves.add(PokeApiMoves.getMove(id));
        }
        
        insert moves;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Termino el batch');
    }
}