//
//  iOS5_BlomeApp.swift
//  iOS5-Blome
//
//  Created by Jonas Blome on 28.01.23.
//

import SwiftUI

@main
struct iOS5_BlomeApp: App {
    var body: some Scene {
        WindowGroup {
            AddressBookView(VM: AddressBookViewModel())
        }
    }
}
