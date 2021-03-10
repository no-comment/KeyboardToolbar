import SwiftUI

public struct KeyboardToolbarItem: Identifiable {
    public let id: UUID = UUID()
    let image: Image
    let callback: () -> Void
    let color: Color
    let isFixed: KeyboardToolbarEdge?
    
    public init(_ image: Image, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.image = image
        self.callback = callback
        self.color = color
        self.isFixed = isFixed
    }
    
    public init(_ systemName: String, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(Image(systemName: systemName), color: color, isFixed: isFixed, callback: callback)
    }
    
    public init(name: String, color: Color = .primary, isFixed: KeyboardToolbarEdge? = nil, callback: @escaping () -> Void) {
        self.init(Image(name), color: color, isFixed: isFixed, callback: callback)
    }
}

public enum KeyboardToolbarEdge {
    case leading, trailing
}

// MARK: Presets
public extension KeyboardToolbarItem {
    static let dismissKeyboard = KeyboardToolbarItem("xmark.circle", color: .accentColor, isFixed: .trailing, callback: {})
}
