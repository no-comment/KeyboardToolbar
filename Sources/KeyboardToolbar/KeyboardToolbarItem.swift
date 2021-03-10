import SwiftUI

public struct KeyboardToolbarItem: Identifiable {
    public var id: UUID = UUID()
    var image: Image
    var callback: () -> Void
    var color: Color
    
    public init(_ image: Image, color: Color = .primary, callback: @escaping () -> Void) {
        self.image = image
        self.callback = callback
        self.color = color
    }
    
    public init(_ systemName: String, color: Color = .primary, callback: @escaping () -> Void) {
        self.init(Image(systemName: systemName), color: color, callback: callback)
    }
    
    public init(name: String, color: Color = .primary, callback: @escaping () -> Void) {
        self.init(Image(name), color: color, callback: callback)
    }
}
