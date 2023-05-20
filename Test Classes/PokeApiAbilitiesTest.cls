//Clase Test de 'PokeApiAbilities' //

@isTest
private class PokeApiAbilitiesTest {
	@isTest
    static void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new PokeApiAbilitiesHttpCalloutMock());
        
        HttpResponse response = PokeApiAbilities.getResponse(1);
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"effect_entries": [{"effect": "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.\n\nDer Effekt stapelt nicht mit dem von getragenen Items.\n\nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.","language": {"name": "de","url": "https://pokeapi.co/api/v2/language/6/"},"short_effect": "Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen."},{"effect": "This Pokémons damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has a 10% chance of making target Pokémon flinch with each hit."}],"id": 1,"name": "stench" }';
    	System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
    
    @isTest
    static void testParse() {
        Test.setMock(HttpCalloutMock.class, new PokeApiAbilitiesHttpCalloutMock());
        String json = '{"effect_entries": [{"effect": "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.\n\nDer Effekt stapelt nicht mit dem von getragenen Items.\n\nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf.","language": {"name": "de","url": "https://pokeapi.co/api/v2/language/6/"},"short_effect": "Mit jedem Treffer besteht eine 10% Chance das Ziel zurückschrecken zu lassen."},{"effect": "This Pokémons damaging moves have a 10% chance to make the target flinch with each hit if they do not already cause flinching as a secondary effect.\n\nThis ability does not stack with a held item.\n\nOverworld: The wild encounter rate is halved while this Pokémon is first in the party.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Has a 10% chance of making target Pokémon flinch with each hit."}],"id": 1,"name": "stench" }';
    	
        PokeApiAbilities.PokeApiWrapperAbility result = PokeApiAbilities.PokeApiWrapperAbility.parse(json);
        
        System.assertEquals('stench', result.name, 'Name should be stench');
        System.assertEquals(1, result.id, 'ID should be 1');
        System.assertEquals('Has a 10% chance of making target Pokémon flinch with each hit.', result.effect_entries[1].short_effect, 'Effect not expected');
    }
    
    @isTest
    static void testGetAbility() {
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setStatusCode(200);
        mockResponse.setBody('{"name": "overgrow", "id": 1, "effect_entries": [{"language": {"name": "en"}, "short_effect": "Grass-type attacks are stronger."}]}');
    	Test.setMock(HttpCalloutMock.class, new MockHttpCallout(mockResponse));
        
        Habilidad__c ability = PokeApiAbilities.getAbility(1);
        
        System.assertEquals('Overgrow', ability.Name);
        System.assertEquals(1, ability.ExtId__c);
        System.assertEquals('Grass-type attacks are stronger.', ability.Effect_Entries_short_effect__c);
    }
}