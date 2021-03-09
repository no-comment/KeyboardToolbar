//
//  File.swift
//  
//
//  Created by Cameron Shemilt on 09.03.21.
//

import SwiftUI

private struct AppendKeyboardToolbar: ViewModifier {
    @ObservedObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.bottom, responder.currentHeight == 0 ? 0 : 40)
            
            VStack {
                Spacer()
                KeyboardToolbar(items: items)
            }.opacity(responder.currentHeight == 0 ? 0 : 1)
            .animation(.easeOut(duration: responder.duration))
        }
        .padding(.bottom, responder.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut(duration: responder.duration))
    }
}

extension View {
    func keyboardToolbar(_ items: [KeyboardToolbarItem]) -> some View {
        self.modifier(AppendKeyboardToolbar(items: items))
    }
}
