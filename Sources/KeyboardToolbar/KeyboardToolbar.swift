#if canImport(UIKit)
import SwiftUI

/// The floating capsule toolbar shown above the keyboard.
struct KeyboardToolbar: View {
    let items: [KeyboardToolbarItem]
    let style: KeyboardToolbarStyle

    /// Gap between the capsule's edge and the items, so selection capsules sit concentrically inside it.
    private let inset: CGFloat = 4

    private var itemHeight: CGFloat {
        max(style.height - inset * 2, 0)
    }

    var body: some View {
        let groups = ItemGroups(items)

        HStack(spacing: 0) {
            if !groups.leading.isEmpty {
                row(groups.leading, distributed: false)
                divider
            }

            if groups.scrolling.isEmpty {
                Spacer(minLength: 0)
            } else if style.distributesItems {
                ViewThatFits(in: .horizontal) {
                    // A single item has no spacers to stretch, so fill the width to keep pinned items at the edges.
                    row(groups.scrolling, distributed: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    scrollingRow(groups.scrolling)
                }
            } else {
                scrollingRow(groups.scrolling)
            }

            if !groups.trailing.isEmpty {
                divider
                row(groups.trailing, distributed: false)
            }
        }
        .padding(.horizontal, inset)
        // The capsule keeps a fixed height like system bars, so cap text there and offer the large content viewer instead.
        .dynamicTypeSize(...DynamicTypeSize.accessibility1)
        .frame(height: style.height)
        .frame(maxWidth: .infinity)
        .modifier(ToolbarBackground(background: style.background))
        .accessibilityElement(children: .contain)
    }

    private func scrollingRow(_ items: [KeyboardToolbarItem]) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    // Each item carries its trailing separator, so snapping aligns to item edges.
                    HStack(spacing: 0) {
                        ItemButton(item: item, style: style, height: itemHeight)
                        if index < items.count - 1 {
                            separator(flexible: false)
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .clipShape(.capsule)
    }

    private func row(_ items: [KeyboardToolbarItem], distributed: Bool) -> some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                if index > 0 {
                    separator(flexible: distributed)
                }
                ItemButton(item: item, style: style, height: itemHeight)
            }
        }
    }

    @ViewBuilder
    private func separator(flexible: Bool) -> some View {
        gap(flexible: flexible)
        if style.dividerBetweenItems {
            divider
            gap(flexible: flexible)
        }
    }

    @ViewBuilder
    private func gap(flexible: Bool) -> some View {
        if flexible {
            Spacer(minLength: style.itemSpacing)
        } else {
            Spacer(minLength: 0).frame(width: style.itemSpacing)
        }
    }

    private var divider: some View {
        Capsule()
            .fill(style.dividerColor)
            .frame(width: style.dividerWidth, height: style.height / 2)
            .padding(.horizontal, style.itemSpacing / 2)
            .accessibilityHidden(true)
    }
}

/// Splits items into the groups pinned to either edge and the scrolling remainder, preserving order.
struct ItemGroups {
    var leading: [KeyboardToolbarItem] = []
    var scrolling: [KeyboardToolbarItem] = []
    var trailing: [KeyboardToolbarItem] = []

    init(_ items: [KeyboardToolbarItem]) {
        for item in items {
            switch item.isFixed {
            case .leading: leading.append(item)
            case .trailing: trailing.append(item)
            case nil: scrolling.append(item)
            }
        }
    }
}

/// A single tappable item, highlighted with a filled capsule when selected.
private struct ItemButton: View {
    let item: KeyboardToolbarItem
    let style: KeyboardToolbarStyle
    let height: CGFloat

    var body: some View {
        Button(action: item.callback) {
            label
                .foregroundStyle(item.isSelected ? Color.white : item.color ?? Color.primary)
                .padding(.horizontal, 10)
                .frame(minWidth: height, minHeight: height)
                .background {
                    if item.isSelected {
                        Capsule().fill(style.selectionColor ?? .accentColor)
                    }
                }
                .contentShape(.capsule)
                .contentShape(.hoverEffect, .capsule)
                .hoverEffect()
        }
        .buttonStyle(ItemButtonStyle())
        .accessibilityShowsLargeContentViewer()
        .modifier(OptionalAccessibilityLabel(label: item.accessibilityLabel))
        .accessibilityAddTraits(item.isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private var label: some View {
        switch item.content {
        case .systemImage(let name):
            Image(systemName: name)
                .font(.system(size: style.itemSize, weight: .medium))
        case .image(let image):
            image
                .resizable()
                .scaledToFit()
                .frame(height: style.itemSize)
        case .text(let text):
            Text(text)
                .font(style.font)
                .lineLimit(1)
                .fixedSize()
        }
    }
}

private struct ItemButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .animation(.spring(duration: 0.2), value: configuration.isPressed)
    }
}

private struct OptionalAccessibilityLabel: ViewModifier {
    let label: Text?

    func body(content: Content) -> some View {
        if let label {
            content.accessibilityLabel(label)
        } else {
            content
        }
    }
}

private struct ToolbarBackground: ViewModifier {
    let background: KeyboardToolbarStyle.Background

    func body(content: Content) -> some View {
        switch background {
        case .glass:
            glass(content, tint: nil)
        case .tintedGlass(let tint):
            glass(content, tint: tint)
        case .color(let color):
            content
                .background(color, in: .capsule)
                .shadow(color: .black.opacity(0.12), radius: 12, y: 4)
        }
    }

    @ViewBuilder
    private func glass(_ content: Content, tint: Color?) -> some View {
        #if compiler(>=6.2)
        if #available(iOS 26, *) {
            content.glassEffect(.regular.tint(tint).interactive(), in: .capsule)
        } else {
            materialFallback(content, tint: tint)
        }
        #else
        materialFallback(content, tint: tint)
        #endif
    }

    private func materialFallback(_ content: Content, tint: Color?) -> some View {
        content
            .background {
                Capsule()
                    .fill(.bar)
                    .overlay {
                        if let tint {
                            Capsule().fill(tint.opacity(0.3))
                        }
                    }
                    .overlay {
                        Capsule().strokeBorder(.white.opacity(0.15), lineWidth: 0.5)
                    }
                    .shadow(color: .black.opacity(0.12), radius: 12, y: 4)
            }
    }
}

#Preview("Glass") {
    @Previewable @State var selected = 0
    let symbols = ["calendar.badge.clock", "location", "number", "flag", "camera"]

    ZStack(alignment: .bottom) {
        LinearGradient(colors: [.indigo, .pink, .orange], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()

        VStack(spacing: 24) {
            KeyboardToolbar(items: symbols.enumerated().map { index, symbol in
                KeyboardToolbarItem(systemName: symbol, isSelected: index == selected) { selected = index }
            }, style: .standard)

            KeyboardToolbar(items: [
                .init(text: "auto", callback: {}),
                .init(text: "complete", callback: {}),
                .init(text: "text", callback: {}),
                .dismissKeyboard,
            ], style: .standard.withDividerBetweenItems())

            KeyboardToolbar(items: [
                .init(systemName: "bold", callback: {}),
                .init(systemName: "italic", callback: {}),
                .init(systemName: "underline", callback: {}),
                .init(systemName: "strikethrough", callback: {}),
                .init(systemName: "list.bullet", callback: {}),
                .init(systemName: "list.number", callback: {}),
                .init(systemName: "link", callback: {}),
                .init(systemName: "photo", callback: {}),
                .init(systemName: "paperclip", callback: {}),
                .init(systemName: "textformat", isFixed: .leading, callback: {}),
                .dismissKeyboard,
            ], style: .standard)

            KeyboardToolbar(items: [
                .init(text: #"\sum"#, callback: {}),
                .init(text: #"\int"#, callback: {}),
                .init(text: #"\epsilon"#, callback: {}),
                .dismissKeyboard,
            ], style: .contrast.withDistributesItems(false))
        }
        .padding(16)
    }
}
#endif
