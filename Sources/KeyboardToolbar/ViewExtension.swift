import SwiftUI

internal struct AppendKeyboardToolbar: ViewModifier {
    @StateObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.bottom, (responder.currentHeight == 0 || items.isEmpty) ? 0 : style.height)
            
            VStack(spacing: 0) {
                Spacer()
                
                if !items.isEmpty {
                    Rectangle()
                        .foregroundColor(style.dividerColor)
                        .frame(height: style.dividerWidth)
                    
                    KeyboardToolbar(items: items, style: style)
                }
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
