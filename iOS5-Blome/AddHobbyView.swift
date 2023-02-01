//
//  AddHobbyView.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 29.01.23.
//

import SwiftUI

struct AddHobbyView: View {
    @State var newHobby: String = ""
    var completed: (String) -> Void
    var body: some View {
        Form {
            TextField("Hobby", text: $newHobby)
        }
        .navigationTitle("Add Hobby")
        .onDisappear {
            completed(newHobby)
        }
    }
}
