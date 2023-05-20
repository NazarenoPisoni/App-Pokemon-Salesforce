//Clase 'PokemonController' que utiliza el LWC para mostrar los campos principales de cada Pokemon.//

public with sharing class PokemonController {
    @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> getPokemons() {
        return [
            SELECT Id, ExtId__c, Name, Image__c, Types__c, Generacion__c
            FROM Pokemon__c
            WITH SECURITY_ENFORCED
            ORDER BY ExtId__c
        ];
    }
}