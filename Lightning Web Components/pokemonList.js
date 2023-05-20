import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getPokemons from '@salesforce/apex/PokemonController.getPokemons';

export default class PokemonList extends NavigationMixin(LightningElement) {
    
    @wire(getPokemons)
    pokemons;
    options = [
        { label: 'Normal', value: 'Normal' },
        { label: 'Fire', value: 'Fire' },
        { label: 'Water', value: 'Water' },
        { label: 'Grass', value: 'Grass' },
        { label: 'Fighting', value: 'Fighting' },
        { label: 'Flying', value: 'Flying' },
        { label: 'Poison', value: 'Poison' },
        { label: 'Ground', value: 'Ground' },
        { label: 'Rock', value: 'Rock' },
        { label: 'Bug', value: 'Bug' },
        { label: 'Ghost', value: 'Ghost' },
        { label: 'Steel', value: 'Steel' },
        { label: 'Electric', value: 'Electric' },
        { label: 'Psychic', value: 'Psychic' },
        { label: 'Ice', value: 'Ice' },
        { label: 'Dragon', value: 'Dragon' },
        { label: 'Dark', value: 'Dark' },
        { label: 'Fairy', value: 'Fairy' },
    ];
    optionsGen = [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: '4', value: '4' },
        { label: '5', value: '5' },
        { label: '6', value: '6' },
        { label: '7', value: '7' },
        { label: '8', value: '8' },
    ];
    selectedType = '';
    selectedGen = 1;
    searchKey = '';
    generationSearchKey = '';
    nameSearchKey = '';
    count = 0;
    filteredData = [];
    isSelectAll = false;

    applyFilters(){
        this.filteredData = this.pokemons.data.filter(pokemon => {
            if (this.isSelectAll) {
                return true;
            }
            return pokemon.Types__c.toLowerCase().includes(this.searchKey.toLowerCase()) &&
                   pokemon.Generacion__c.toString().includes(this.generationSearchKey) &&
                   pokemon.Name.toLowerCase().includes(this.nameSearchKey.toLowerCase());
        });
        this.count = this.filteredData.length;
    }  
    
    selectAll() {
        this.isSelectAll = !this.isSelectAll;
        this.applyFilters();
    }

    handleNameSearch(event) {
        this.nameSearchKey = event.target.value;
        this.applyFilters();
    }
    
    handleTypeChange(event) {
        this.selectedType = event.detail.value;
        this.searchKey = this.selectedType;
        this.applyFilters();
    }

    handleGenChange(event) {
        this.selectedGen = event.detail.value;
        this.generationSearchKey = this.selectedGen;
        this.applyFilters();
    }

    handleClick(event) {
        
        const recordId = event.currentTarget.getAttribute('data-recordid');
        
        const pageReference = {
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Pokemon__c', 
                actionName: 'view'
            }
        };
        
        this[NavigationMixin.Navigate](pageReference);
    }

}