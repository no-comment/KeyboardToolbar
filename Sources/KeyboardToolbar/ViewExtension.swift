import SwiftUI

internal struct AppendKeyboardToolbar: ViewModifier {
    @StateObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.bottom, responder.currentHeight == 0 ? 0 : 40)
            
            VStack(spacing: 0) {
                Spacer()
                
                Divider()
                    .foregroundColor(style.dividerColor)
                
                KeyboardToolbar(items: items, style: style)
            }
            .opacity(responder.currentHeight == 0 ? 0 : 1)
            .animation(.easeOut(duration: responder.duration))
        }
        .padding(.bottom, responder.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut(duration: responder.duration))
    }
}

public extension View {
    func keyboardToolbar(_ items: [KeyboardToolbarItem], style: KeyboardToolbarStyle = .standard) -> some View {
        self.modifier(AppendKeyboardToolbar(items: items, style: style))
    }
}
