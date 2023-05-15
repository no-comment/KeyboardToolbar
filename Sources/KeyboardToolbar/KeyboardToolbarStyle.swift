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

public extension KeyboardToolbarStyle {
    func withBackgroundColor(_ color: Color = Color(UIColor.systemGray4)) -> Self {
        return .init(backgroundColor: color, height: self.height, itemSize: self.itemSize, itemSpacing: self.itemSpacing, dividerColor: self.dividerColor, dividerWidth: self.dividerWidth, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withHeight(_ h: CGFloat = 40) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: h, itemSize: self.itemSize, itemSpacing: self.itemSpacing, dividerColor: self.dividerColor, dividerWidth: self.dividerWidth, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withItemSize(_ s: CGFloat = 20) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: self.height, itemSize: s, itemSpacing: self.itemSpacing, dividerColor: self.dividerColor, dividerWidth: self.dividerWidth, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withItemSpacing(_ s: CGFloat = 10) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: self.height, itemSize: self.itemSize, itemSpacing: s, dividerColor: self.dividerColor, dividerWidth: self.dividerWidth, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withDividerColor(_ c: Color = .gray) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: self.height, itemSize: self.itemSize, itemSpacing: self.itemSpacing, dividerColor: c, dividerWidth: self.dividerWidth, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withDividerWidth(_ w: CGFloat = 0.5) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: self.height, itemSize: self.itemSize, itemSpacing: self.itemSpacing, dividerColor: self.dividerColor, dividerWidth: w, dividerBetweenItems: self.dividerBetweenItems)
    }

    func withDividerBetweenItems(_ b: Bool = false) -> Self {
        return .init(backgroundColor: self.backgroundColor, height: self.height, itemSize: self.itemSize, itemSpacing: self.itemSpacing, dividerColor: self.dividerColor, dividerWidth: self.dividerWidth, dividerBetweenItems: b)
    }
}

// MARK: Style Presets

public extension KeyboardToolbarStyle {
    static let standard = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemGray4))
    static let contrast = KeyboardToolbarStyle(backgroundColor: Color(UIColor.systemBackground), dividerColor: Color(UIColor.systemGray4), dividerWidth: 1)
}
#endif
