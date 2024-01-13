//
//  EditButton.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

struct EditButton: View {
    
    @Binding var editButton: EditMode
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: {
            if editButton == .active {
                action()
                editButton = .inactive
            } else {
                editButton = .active
            }
        }, label: {
            if editButton == .active {
                Text("Cancel").bold()
            } else {
                Text("Edit")
                    .bold()
            }
        })
    }
}

#Preview {
    EditButton(editButton: .constant(.active))
}
