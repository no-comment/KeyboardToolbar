import SwiftUI

public struct KeyboardToolbarStyle {
    let backgroundColor: Color
    let dividerColor: Color
    let height: CGFloat
    let itemSize: CGFloat
    let itemSpacing: CGFloat
    
    public init(backgroundColor: Color = Color(UIColor.systemGray4), dividerColor: Color = .gray, height: CGFloat = 40, itemSize: CGFloat = 20, itemSpacing: CGFloat = 10) {
        self.backgroundColor = backgroundColor
        self.dividerColor = dividerColor
        self.height = height
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
    }
}

// MARK: Style Presets
public extension KeyboardToolbarStyle {
    static let standard = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemGray4))
    
    static let contrast = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemBackground), dividerColor: Color(UIColor.systemGray))
}
