#if canImport(UIKit)
import SwiftUI

internal struct AppendKeyboardToolbar: ViewModifier {
    @StateObject var responder: KeyboardResponder = KeyboardResponder()
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle
    
    func body(content: Content) -> some View {
        content.overlay(toolbarContainer, alignment: .bottom)
    }
    
    var toolbarContainer: some View {
        VStack(spacing: 0) {
            Spacer()
            
            if !items.isEmpty {
                toolbar
            }
        }
        .opacity(responder.visible ? 1 : 0)
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
