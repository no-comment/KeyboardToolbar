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
                    toolbar
                }
            }
            .opacity(responder.currentHeight == 0 ? 0 : 1)
            .animation(.easeOut(duration: responder.duration))
        }
        .padding(.bottom, responder.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut(duration: responder.duration))
    }
    
    var toolbar: some View {
        ZStack {
            // Empty bar in background to fill safe areas
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(style.dividerColor)
                    .frame(height: style.dividerWidth)
                
                Rectangle()
                    .foregroundColor(style.backgroundColor)
                    .frame(height: style.height)
            }
            .edgesIgnoringSafeArea(.horizontal)
            
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(style.dividerColor)
                    .frame(height: style.dividerWidth)
                
                KeyboardToolbar(items: items, style: style)
            }
        }
    }
}

public extension View {
    func keyboardToolbar(_ items: [KeyboardToolbarItem], style: KeyboardToolbarStyle = .standard) -> some View {
        self.modifier(AppendKeyboardToolbar(items: items, style: style))
    }
}
