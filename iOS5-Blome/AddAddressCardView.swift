//
//  AddAddressCardView.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 29.01.23.
//

import SwiftUI

struct AddAddressCardView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var street: String = ""
    @State var postalCode: String = ""
    @State var city: String = ""
    var completed: (String, String, String, String, String) -> Void
    
    var body: some View {
        Form {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Street", text: $street)
            TextField("Postal Code", text: $postalCode)
            TextField("City", text: $city)
        }
        .navigationTitle("New Address Card")
        .onDisappear {
            if firstName != "" && lastName != "" {
                completed(firstName, lastName, street, postalCode, city)
            }
        }
    }
}
