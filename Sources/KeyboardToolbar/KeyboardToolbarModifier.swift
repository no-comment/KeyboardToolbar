#if canImport(UIKit)
import SwiftUI

struct KeyboardToolbarModifier: ViewModifier {
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle

    @State private var isKeyboardVisible = false

    func body(content: Content) -> some View {
        content
            // Insetting the safe area (instead of overlaying) keeps the toolbar riding on top of the
            // keyboard and lets scroll views move focused fields above the toolbar instead of behind it.
            .safeAreaInset(edge: .bottom, spacing: 0) {
                if isKeyboardVisible && !items.isEmpty {
                    KeyboardToolbar(items: items, style: style)
                        .padding(style.margins)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                setKeyboardVisible(true, notification: notification)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                setKeyboardVisible(false, notification: notification)
            }
    }

    private func setKeyboardVisible(_ visible: Bool, notification: Notification) {
        guard visible != isKeyboardVisible else { return }
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.25
        withAnimation(.smooth(duration: max(duration, 0.1))) {
            isKeyboardVisible = visible
        }
    }
}

public extension View {
    /// Shows a floating toolbar above the keyboard while it is visible.
    ///
    /// Attach this to the outermost view of a screen, e.g. the `Form` or `ScrollView` inside a `NavigationStack`.
    /// - Parameters:
    ///   - items: The items the toolbar contains. The toolbar is hidden when this is empty.
    ///   - style: Styling of the keyboard toolbar.
    @ViewBuilder
    func keyboardToolbar(_ items: [KeyboardToolbarItem], style: KeyboardToolbarStyle = .standard) -> some View {
        #if targetEnvironment(macCatalyst)
        self
        #else
        modifier(KeyboardToolbarModifier(items: items, style: style))
        #endif
    }
}

#Preview("Form") {
    @Previewable @State var name = ""
    @Previewable @State var notes = ""
    @Previewable @State var isBold = false

    NavigationStack {
        Form {
            Section {
                TextField("Name", text: $name)
                TextField("Notes", text: $notes, axis: .vertical)
                    .lineLimit(3...)
            }
            Section {
                Text("Tap a field to show the keyboard toolbar.")
            }
        }
        .navigationTitle("Keyboard Toolbar")
        .keyboardToolbar([
            .init(systemName: "bold", isSelected: isBold, accessibilityLabel: Text("Bold")) { isBold.toggle() },
            .init(systemName: "italic", accessibilityLabel: Text("Italic")) {},
            .init(systemName: "underline", accessibilityLabel: Text("Underline")) {},
            .dismissKeyboard,
        ])
    }
}
#endif
