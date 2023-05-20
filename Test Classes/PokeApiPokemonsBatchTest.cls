//Clase Test de 'PokeApiPokemonsBatch' //

@isTest
private class PokeApiPokemonsBatchTest {
    
    @isTest
    static void testStartMethod() {
        PokeApiPokemonsBatch batch = new PokeApiPokemonsBatch();
        List<Integer> ids = batch.start(null);
        System.assertEquals(898, ids.size(), 'Expected 898 ids');
        
    }
    
    @isTest
	static void testExecuteMethod() {

        PokeApiPokemonsBatch batch = new PokeApiPokemonsBatch();
        
        List<Integer> testIds = new List<Integer>();
        for(Integer i = 1; i <= 898; i++) {
            testIds.add(i);
        }
        
       	Test.startTest();
        batch.execute(null, testIds);
        Test.stopTest();
        
        List<Pokemon__c> pokemons = [SELECT Id FROM Pokemon__c];
        System.assertEquals(898, pokemons.size(), 'Expected 898 pokemons records');
	
    }
    
    @isTest
    static void testFinishMethod() {
        PokeApiPokemonsBatch batch = new PokeApiPokemonsBatch();
        batch.finish(null);
        
   	}   
}