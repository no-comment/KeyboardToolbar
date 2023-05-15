#if canImport(UIKit)
import SwiftUI

public struct KeyboardToolbarStyle {
    let backgroundColor: Color
    let height: CGFloat
    let itemSize: CGFloat
    let itemSpacing: CGFloat
    let dividerColor: Color
    let dividerWidth: CGFloat
    let dividerBetweenItems: Bool

    public init(
        backgroundColor: Color = Color(UIColor.systemGray4),
        height: CGFloat = 40,
        itemSize: CGFloat = 20,
        itemSpacing: CGFloat = 10,
        dividerColor: Color = .gray,
        dividerWidth: CGFloat = 0.5,
        dividerBetweenItems: Bool = false
    ) {
        self.backgroundColor = backgroundColor
        self.height = height
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
        self.dividerColor = dividerColor
        self.dividerWidth = dividerWidth
        self.dividerBetweenItems = dividerBetweenItems
    }
}

    }
}

// MARK: Style Presets

public extension KeyboardToolbarStyle {
    static let standard = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemGray4))
    static let contrast = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemBackground), dividerColor: Color(UIColor.systemGray4), dividerWidth: 1)
}
#endif
