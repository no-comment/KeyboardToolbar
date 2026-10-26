#if canImport(UIKit)
import SwiftUI

/// A single button inside a ``KeyboardToolbar``.
public struct KeyboardToolbarItem: Identifiable {
    enum Content {
        case systemImage(String)
        case image(Image)
        case text(String)
    }

    public let id = UUID()
    let content: Content
    let color: Color?
    let isFixed: KeyboardToolbarEdge?
    let isSelected: Bool
    let accessibilityLabel: Text?
    let callback: @MainActor () -> Void

    init(
        content: Content,
        color: Color?,
        isFixed: KeyboardToolbarEdge?,
        isSelected: Bool,
        accessibilityLabel: Text?,
        callback: @escaping @MainActor () -> Void
    ) {
        self.content = content
        self.color = color
        self.isFixed = isFixed
        self.isSelected = isSelected
        self.accessibilityLabel = accessibilityLabel
        self.callback = callback
    }

    /// Creates an item displaying a custom image.
    /// - Parameters:
    ///   - image: The image to display. It is resized to fit the style's `itemSize`.
    ///   - color: Foreground color. Defaults to the primary color.
    ///   - isFixed: Pins the item to an edge so it doesn't scroll with the other items.
    ///   - isSelected: Highlights the item with a filled capsule, e.g. to show an active mode.
    ///   - accessibilityLabel: VoiceOver label. Strongly recommended for image items.
    ///   - callback: Action performed when the item is tapped.
    public init(
        image: Image,
        color: Color? = nil,
        isFixed: KeyboardToolbarEdge? = nil,
        isSelected: Bool = false,
        accessibilityLabel: Text? = nil,
        callback: @escaping @MainActor () -> Void
    ) {
        self.init(content: .image(image), color: color, isFixed: isFixed, isSelected: isSelected, accessibilityLabel: accessibilityLabel, callback: callback)
    }

    /// Creates an item displaying an SF Symbol.
    public init(
        systemName: String,
        color: Color? = nil,
        isFixed: KeyboardToolbarEdge? = nil,
        isSelected: Bool = false,
        accessibilityLabel: Text? = nil,
        callback: @escaping @MainActor () -> Void
    ) {
        self.init(content: .systemImage(systemName), color: color, isFixed: isFixed, isSelected: isSelected, accessibilityLabel: accessibilityLabel, callback: callback)
    }

    /// Creates an item displaying an image from the asset catalog.
    public init(
        imageName: String,
        color: Color? = nil,
        isFixed: KeyboardToolbarEdge? = nil,
        isSelected: Bool = false,
        accessibilityLabel: Text? = nil,
        callback: @escaping @MainActor () -> Void
    ) {
        self.init(content: .image(Image(imageName)), color: color, isFixed: isFixed, isSelected: isSelected, accessibilityLabel: accessibilityLabel, callback: callback)
    }

    /// Creates an item displaying text.
    public init(
        text: String,
        color: Color? = nil,
        isFixed: KeyboardToolbarEdge? = nil,
        isSelected: Bool = false,
        accessibilityLabel: Text? = nil,
        callback: @escaping @MainActor () -> Void
    ) {
        self.init(content: .text(text), color: color, isFixed: isFixed, isSelected: isSelected, accessibilityLabel: accessibilityLabel, callback: callback)
    }
}

public enum KeyboardToolbarEdge: Sendable {
    case leading, trailing
}

// MARK: Presets

public extension KeyboardToolbarItem {
    /// A button pinned to the trailing edge that dismisses the keyboard.
    static var dismissKeyboard: KeyboardToolbarItem {
        KeyboardToolbarItem(
            systemName: "keyboard.chevron.compact.down",
            isFixed: .trailing,
            accessibilityLabel: Text("Dismiss Keyboard"),
            callback: dismissKeyboardAction
        )
    }
}

@MainActor
func dismissKeyboardAction() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
#endif
