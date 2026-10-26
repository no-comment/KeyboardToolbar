#if canImport(UIKit)
import SwiftUI
import Testing
@testable import KeyboardToolbar

@MainActor
struct KeyboardToolbarTests {
    @Test func groupsItemsByEdgePreservingOrder() {
        let items: [KeyboardToolbarItem] = [
            .init(text: "a", callback: {}),
            .init(text: "lead", isFixed: .leading, callback: {}),
            .init(text: "b", callback: {}),
            .dismissKeyboard,
            .init(text: "c", callback: {}),
        ]

        let groups = ItemGroups(items)

        #expect(groups.leading.map(\.text) == ["lead"])
        #expect(groups.scrolling.map(\.text) == ["a", "b", "c"])
        #expect(groups.trailing.map(\.id) == [items[3].id])
    }

    @Test func dismissKeyboardPresetIsPinnedTrailing() {
        #expect(KeyboardToolbarItem.dismissKeyboard.isFixed == .trailing)
    }

    @Test func styleBuildersOnlyChangeTheirProperty() {
        let style = KeyboardToolbarStyle.standard
            .withHeight(60)
            .withItemSpacing(12)
            .withDividerBetweenItems()

        #expect(style.height == 60)
        #expect(style.itemSpacing == 12)
        #expect(style.dividerBetweenItems)
        #expect(style.itemSize == KeyboardToolbarStyle.standard.itemSize)
    }
}

private extension KeyboardToolbarItem {
    var text: String? {
        if case .text(let text) = content { text } else { nil }
    }
}
#endif
