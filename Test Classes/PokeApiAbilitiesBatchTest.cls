//Clase Test de 'PokeApiAbilitiesBatch'//

@isTest
private class PokeApiAbilitiesBatchTest {
	@isTest
    static void testStartMethod() {
        PokeApiAbilitiesBatch batch = new PokeApiAbilitiesBatch();
        List<Integer> ids = batch.start(null);
        System.assertEquals(267, ids.size(), 'Expected 267 ids');
        
   	}
    
    @isTest
	static void testExecuteMethod() {
    
    	PokeApiAbilitiesBatch batch = new PokeApiAbilitiesBatch();
            
        List<Integer> testIds = new List<Integer>();
        for(Integer i = 1; i <= 267; i++) {
            testIds.add(i);
   		}
    
        Test.startTest();
        batch.execute(null, testIds);
        Test.stopTest();
        
        List<Habilidad__c> abilities = [SELECT Id FROM Habilidad__c];
        System.assertEquals(267, abilities.size(), 'Expected 267 ability records');
	
    }
    
    @isTest
    static void testFinishMethod() {
        PokeApiAbilitiesBatch batch = new PokeApiAbilitiesBatch();
    	batch.finish(null);

    }
}