//
//  ContentView.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import SwiftUI

struct AddressBookView: View {
    @ObservedObject var VM: AddressBookViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(VM.addressCards) { addressCard in
                    addressCardView(addressCard: addressCard)
                }
                .onDelete { indexSet in
                    VM.addressCards.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Addresses")
            .toolbar {
                toolbarContent
            }
            .searchable(text: $searchText, prompt: "Search for addresses")
        }
    }
    
    var searchResults: [AddressCard] {
        if searchText.isEmpty {
            return VM.addressCards
        } else {
            return [VM.getCardByName(name: searchText)]
        }
    }
    
    @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
        ToolbarItem {
            EditButton()
        }
        ToolbarItem {
            NavigationLink {
                AddAddressCardView {
                    firstName, lastName, street, postalCode, city in
                    VM.addCard(firstName: firstName, lastName: lastName, street: street, postalCode: postalCode, city: city)
                }
            } label: {
                Image(systemName: "plus")
            }
        }
    }
    
    func addressCardView(addressCard: AddressCard) -> some View {
        NavigationLink(destination: AddressCardView(addressCard: addressCard)
            .environmentObject(VM)) {
                Label("\(addressCard.firstName) \(addressCard.lastName)", systemImage: "person.crop.circle")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddressBookView(VM: AddressBookViewModel()).environmentObject(AddressBookViewModel())
    }
}
