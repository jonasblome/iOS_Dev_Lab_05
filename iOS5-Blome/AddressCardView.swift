//
//  AddressCardView.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import SwiftUI

struct AddressCardView: View {
    @EnvironmentObject var addressBook: AddressBookViewModel
    
    var addressCard: AddressCard
    var addressCardIndex: Int {
        addressBook.addressCards.firstIndex(of: addressCard) ?? 0
    }
    
    var body : some View {
        VStack {
            List{
                Section(header: Text("Info")){
                    TextEditor(text: $addressBook.addressCards[addressCardIndex].firstName)
                    TextEditor(text: $addressBook.addressCards[addressCardIndex].lastName)
                    TextEditor(text: $addressBook.addressCards[addressCardIndex].street)
                    Text(String(addressBook.addressCards[addressCardIndex].postalCode))
                    TextEditor(text: $addressBook.addressCards[addressCardIndex].city)
                }
                Section(header: Text("Friends")){
                    ForEach(addressBook.addressCards[addressCardIndex].friends, id: \.self){ friendID in
                        if let friend = addressBook.getCardById(id: friendID){
                            Text(friend.firstName + friend.lastName)
                        }
                    }
                    .onDelete{ indexSet in
                        addressBook.addressCards[addressCardIndex].friends.remove(atOffsets: indexSet)
                    }
                    NavigationLink {
                        AddFriendView { friend in
                            addressBook.addressCards[addressCardIndex].add(friend: friend)
                        }
                        .environmentObject(addressBook)
                    } label: {
                        Text("Add Friend")
                    }
                }
                Section(header: Text("Hobbies")){
                    ForEach(addressBook.addressCards[addressCardIndex].hobbies){ hobby in
                        Text(hobby.name)
                    }
                    .onDelete { indexSet in
                        //if let index = card.hobbyList.indexOf(hobby)
                        addressBook.addressCards[addressCardIndex].hobbies.remove(atOffsets: indexSet)
                    }
                    NavigationLink {
                        AddHobbyView { hobbyName in
                            addressBook.addressCards[addressCardIndex].add(hobby: Hobby(name: hobbyName))
                        }
                    } label: {
                        Text("Add Hobby")
                    }
                }
            }
            .navigationTitle(Text("\(addressCard.firstName) \(addressCard.lastName)"))
            .toolbar{
                toolbarContent
            }
        }
    }
    
    @ToolbarContentBuilder var toolbarContent: some ToolbarContent {
        ToolbarItem{
            EditButton()
        }
    }
}
