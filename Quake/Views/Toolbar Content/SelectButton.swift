//
//  SelectButton.swift
//  Quake
//
//  Created by Abdelrahman Shehab on 13/01/2024.
//

import SwiftUI

enum SelectMode {
    case active
    case inActive
    
    var isActive: Bool {
        self == .active
    }
    
    mutating func toggle() {
        switch self {
        case .active:
            self = .inActive
        case .inActive:
            self = .active
        }
    }
}

struct SelectButton: View {
    @Binding var mode: SelectMode
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: {
            withAnimation {
                mode.toggle()
                action()
            }
        }, label: {
            Text(mode.isActive ? "Deselect All" : "Select All")
        })
    }
}

#Preview {
    SelectButton(mode: .constant(.active))
}
