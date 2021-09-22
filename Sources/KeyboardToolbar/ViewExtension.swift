#if canImport(UIKit)
import SwiftUI

internal struct AppendKeyboardToolbar: ViewModifier {
    @StateObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .padding(.bottom, (responder.currentHeight == 0 || items.isEmpty) ? 0 : responder.currentHeight + style.height)
            
            VStack(spacing: 0) {
                Spacer()
                
                if !items.isEmpty {
                    toolbar
                }
            }
            .opacity(responder.currentHeight == 0 ? 0 : 1)
            .animation(.easeOut(duration: responder.duration))
            .padding(.bottom, responder.currentHeight)
        }
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea(.keyboard)
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
    /// Applies a toolbar to the keyboard of this View. Should be attached to the outermost part of the View.
    /// - Parameters:
    ///   - items: A list of all items the toolbar shall contain.
    ///   - style: Styling of the keyboard toolbar.
    func keyboardToolbar(_ items: [KeyboardToolbarItem], style: KeyboardToolbarStyle = .standard) -> some View {
        #if targetEnvironment(macCatalyst)
        return self
        #else
        return self.modifier(AppendKeyboardToolbar(items: items, style: style))
        #endif
    }
}
#endif
