//Clase Test de 'PokeApiMovesBatch' //

@isTest
private class PokeApiMovesBatchTest {
    @isTest
    static void testStartMethod() {
        PokeApiMovesBatch batch = new PokeApiMovesBatch();
        List<Integer> ids = batch.start(null);
        System.assertEquals(826, ids.size(), 'Expected 826 ids');
        
    }
    
    @isTest
	static void testExecuteMethod() {
        PokeApiMovesBatch batch = new PokeApiMovesBatch();
        
        List<Integer> testIds = new List<Integer>();
        for(Integer i = 1; i <= 826; i++) {
            testIds.add(i);
        }
        
       	Test.startTest();
        batch.execute(null, testIds);
        Test.stopTest();
        
        List<Movimiento__c> moves = [SELECT Id FROM Movimiento__c];
        System.assertEquals(826, moves.size(), 'Expected 826 move records');
	
    }
    
    @isTest
    static void testFinishMethod() {
        PokeApiMovesBatch batch = new PokeApiMovesBatch();
    	batch.finish(null);
		
    }

}