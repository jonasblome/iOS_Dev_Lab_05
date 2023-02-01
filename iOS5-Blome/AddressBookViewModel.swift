//
//  ContactsViewModel.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import Foundation
import Combine

var objectWillChange = ObservableObjectPublisher()

class AddressBookViewModel: ObservableObject {
    @Published private var addressBook = AddressBook()
    
    init() {
        loadData()
    }
    
    func updateViews() {
        objectWillChange.send()
    }
    
    var addressCards: [AddressCard] {
        get{
            return addressBook.addressCards
        }
        set {
            addressBook.addressCards = newValue
            updateViews()
        }
    }
    
    func addCard(firstName: String, lastName: String, street: String, postalCode: String, city: String) {
        // Creating new address card from input data
        let newCard = AddressCard()
        newCard.firstName = firstName
        newCard.lastName = lastName
        newCard.street = street
        newCard.city = city
        if let pc = Int(postalCode){
            newCard.postalCode = pc
        }
        newCard.hobbies = []
        newCard.friends = []
        
        // Adding card to address list and resorting
        addressBook.add(card: newCard)
        addressBook.sortCards()
        
        updateViews()
    }
    
    func remove(card: AddressCard) {
        addressBook.remove(card: card)
    }
    
    func sortCards() {
        addressBook.sortCards()
    }
    
    func friendsOf(card: AddressCard) -> [AddressCard] {
        return addressBook.friendsOf(card: card)
    }
    
    func getCardByName(name: String) -> AddressCard {
        if let _card = addressBook.getCardByName(name: name) {
            return _card
        }
        else {
            return AddressCard()
        }
    }
    
    func getCardById(id: UUID) -> AddressCard {
        if let _card = addressBook.getCardById(id: id) {
            return _card
        }
        else {
            return AddressCard()
        }
    }
    
    func createAddressBook(fromFile path: String) {
        if let addresses = AddressBook.createAddressBook(fromFile: path) {
            self.addressBook = addresses
        }
    }
    
    func loadData(){
        // Check if address book file already exists
        if let _addressBook = AddressBook.createAddressBook(fromFile: "book.json"){
            addressBook = _addressBook
        }
        else{
            addressBook = AddressBook()
            initializeAddresses(adressbook: addressBook)
        }
    }
    
    func saveModel(){
        addressBook.save(toFile: "book.json")
    }
    
    func initializeAddresses(adressbook: AddressBook){
        // Create five initial address cards
        for _ in [0..<5] {
            print("adding card")
            let card = AddressCard()
            card.firstName = "x"
            card.lastName = "x"
            card.street = "x"
            card.postalCode = 12345
            card.city = "x"
            card.add(hobby: Hobby(name: "x"))
            card.add(hobby: Hobby(name: "x"))
            addressBook.add(card: card)
        }
    }
}
