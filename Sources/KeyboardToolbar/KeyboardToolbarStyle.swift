#if canImport(UIKit)
import SwiftUI

public struct KeyboardToolbarStyle: Sendable {
    /// The surface the toolbar capsule is drawn on.
    public enum Background: Sendable {
        /// Liquid Glass on iOS 26 and later, a bar material on earlier versions.
        case glass
        /// Liquid Glass tinted with the given color.
        case tintedGlass(Color)
        /// An opaque fill.
        case color(Color)
    }

    public var background: Background
    /// Height of the toolbar capsule.
    public var height: CGFloat
    /// Point size of icons.
    public var itemSize: CGFloat
    /// Minimum spacing between items.
    public var itemSpacing: CGFloat
    /// Font of text items.
    public var font: Font
    /// Fill of the capsule behind selected items. `nil` uses the accent color.
    public var selectionColor: Color?
    /// Distance between the toolbar and the screen edges and the keyboard.
    public var margins: EdgeInsets
    /// Spreads the items across the full width when they fit, like the system keyboard toolbar.
    /// When `false`, items are packed at the leading edge.
    public var distributesItems: Bool
    public var dividerColor: Color
    public var dividerWidth: CGFloat
    public var dividerBetweenItems: Bool

    public init(
        background: Background = .glass,
        height: CGFloat = 48,
        itemSize: CGFloat = 20,
        itemSpacing: CGFloat = 8,
        font: Font = .body.weight(.medium),
        selectionColor: Color? = nil,
        margins: EdgeInsets = EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8),
        distributesItems: Bool = true,
        dividerColor: Color = Color(uiColor: .separator),
        dividerWidth: CGFloat = 1,
        dividerBetweenItems: Bool = false
    ) {
        self.background = background
        self.height = height
        self.itemSize = itemSize
        self.itemSpacing = itemSpacing
        self.font = font
        self.selectionColor = selectionColor
        self.margins = margins
        self.distributesItems = distributesItems
        self.dividerColor = dividerColor
        self.dividerWidth = dividerWidth
        self.dividerBetweenItems = dividerBetweenItems
    }
}

public extension KeyboardToolbarStyle {
    @available(*, deprecated, message: "Use init(background: .color(_:)) instead, or omit it for Liquid Glass.")
    init(
        backgroundColor: Color,
        height: CGFloat = 48,
        itemSize: CGFloat = 20,
        itemSpacing: CGFloat = 8,
        dividerColor: Color = Color(uiColor: .separator),
        dividerWidth: CGFloat = 1,
        dividerBetweenItems: Bool = false
    ) {
        self.init(
            background: .color(backgroundColor),
            height: height,
            itemSize: itemSize,
            itemSpacing: itemSpacing,
            dividerColor: dividerColor,
            dividerWidth: dividerWidth,
            dividerBetweenItems: dividerBetweenItems
        )
    }

    func withBackground(_ background: Background) -> Self {
        with(\.background, background)
    }

    func withBackgroundColor(_ color: Color) -> Self {
        with(\.background, .color(color))
    }

    func withHeight(_ height: CGFloat) -> Self {
        with(\.height, height)
    }

    func withItemSize(_ size: CGFloat) -> Self {
        with(\.itemSize, size)
    }

    func withItemSpacing(_ spacing: CGFloat) -> Self {
        with(\.itemSpacing, spacing)
    }

    func withFont(_ font: Font) -> Self {
        with(\.font, font)
    }

    func withSelectionColor(_ color: Color?) -> Self {
        with(\.selectionColor, color)
    }

    func withMargins(_ margins: EdgeInsets) -> Self {
        with(\.margins, margins)
    }

    func withDistributesItems(_ distributes: Bool) -> Self {
        with(\.distributesItems, distributes)
    }

    func withDividerColor(_ color: Color) -> Self {
        with(\.dividerColor, color)
    }

    func withDividerWidth(_ width: CGFloat) -> Self {
        with(\.dividerWidth, width)
    }

    func withDividerBetweenItems(_ enabled: Bool = true) -> Self {
        with(\.dividerBetweenItems, enabled)
    }

    private func with<Value>(_ keyPath: WritableKeyPath<Self, Value>, _ value: Value) -> Self {
        var copy = self
        copy[keyPath: keyPath] = value
        return copy
    }
}

// MARK: Style Presets

public extension KeyboardToolbarStyle {
    /// A floating Liquid Glass capsule, matching the system keyboard toolbar.
    static let standard = KeyboardToolbarStyle()
    /// An opaque capsule that stands out against busy content.
    static let contrast = KeyboardToolbarStyle(background: .color(Color(uiColor: .secondarySystemGroupedBackground)))
}
#endif
