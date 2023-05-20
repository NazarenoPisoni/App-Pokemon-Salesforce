//Clase Test de 'PokemonController' //


@isTest
private class PokemonControllerTest {
	@isTest
    static void testGetPokemons() {
        List<Pokemon__c> pokemons = new List<Pokemon__c>();
        pokemons.add(new Pokemon__c(ExtId__c = 1, Name = 'Pikachu', Image__c = 'http://example.com/pikachu.png', 
                                    Types__c = 'Electric'));
        pokemons.add(new Pokemon__c(ExtId__c = 2, Name = 'Charmander', Image__c = 'http://example.com/charmander.png', 
                                    Types__c = 'Fire'));
        insert pokemons;
        
        List<Pokemon__c> result = PokemonController.getPokemons();
        
        System.assertNotEquals(0, result.size(), 'The list of Pokemons should not be empty');
        for (Pokemon__c p : result) {
            System.assertNotEquals(null, p.ExtId__c, 'The Pokemon should have an ExtId__c field');
            System.assertNotEquals(null, p.Name, 'The Pokemon should have a Name field');
            System.assertNotEquals(null, p.Image__c, 'The Pokemon should have an Image__c field');
            System.assertNotEquals(null, p.Types__c, 'The Pokemon should have a Types__c field');
            System.assertNotEquals(null, p.Generacion__c, 'The Pokemon should have a Generacion__c field');
        }
    }
}