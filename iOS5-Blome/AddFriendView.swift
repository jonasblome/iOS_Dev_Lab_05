//
//  AddFriendView.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 29.01.23.
//

import SwiftUI

struct AddFriendView: View {
    @EnvironmentObject var addressBook: AddressBookViewModel
    @State var newFriend = AddressCard()
    var completed: (AddressCard) -> Void
    var body: some View {
        Form {
            Picker("Add Friend", selection: $newFriend) {
                ForEach(addressBook.addressCards, id:\.self) { contact in
                    Text("\(contact.firstName) \(contact.lastName)")
                }
            }
            .pickerStyle(.inline)
        }
        .navigationTitle("Add Friend")
        .onDisappear {
            completed(newFriend)
        }
    }
}
