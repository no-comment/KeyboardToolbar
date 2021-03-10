import SwiftUI

internal struct AppendKeyboardToolbar: ViewModifier {
    @StateObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.bottom, responder.currentHeight == 0 ? 0 : style.height)
            
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
        if items.isEmpty {
            return AnyView(self)
        } else {
            return AnyView(self.modifier(AppendKeyboardToolbar(items: items, style: style)))
        }
    }
}
