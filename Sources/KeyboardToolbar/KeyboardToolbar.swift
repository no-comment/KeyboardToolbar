#if canImport(UIKit)
import SwiftUI

internal struct KeyboardToolbar: View {
    var items: [KeyboardToolbarItem]
    var style: KeyboardToolbarStyle
    var leadingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == .leading }
    }

    var trailingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == .trailing }
    }

    var scrollingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == nil }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            leadingItemsView
            if !leadingItems.isEmpty {
                divider
            }
            scrollingItemsView
            if !trailingItems.isEmpty {
                divider
            }
            trailingItemsView
        }
        .frame(height: style.height)
        .padding(.horizontal, style.itemSpacing)
        .background(style.backgroundColor)
    }
    
    func itemGroup(_ items: [KeyboardToolbarItem]) -> some View {
        ForEach(items, content: {
            itemButton($0)
            if style.dividerBetweenItems && $0.id != items.last?.id {
                divider.padding(.vertical, 5)
            }
        })
    }
    
    func itemButton(_ item: KeyboardToolbarItem) -> some View {
        Button(action: item.callback, label: {
            if (item.image != nil || item.text == nil) {
                (item.image ?? Image(systemName: "placeholdertext.fill"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(item.color)
                    .frame(height: style.itemSize)
                    .frame(minWidth: max(style.itemSize, style.height))
                    .frame(maxHeight: .infinity)
                    .contentShape(Rectangle())
            } else {
                Text(item.text ?? "")
                    .font(.system(size: style.itemSize + 4))
                    .foregroundColor(item.color)
                    .frame(height: style.itemSize)
                    .frame(minWidth: max(style.itemSize, style.height))
                    .frame(maxHeight: .infinity)
                    .contentShape(Rectangle())
            }
        })
        .frame(height: style.height)
        .contentShape(Rectangle())
    }
    
    var leadingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            itemGroup(leadingItems)
        }
    }
    
    var scrollingItemsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: style.itemSpacing) {
                itemGroup(scrollingItems)
            }
        }
    }
    
    var trailingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            itemGroup(trailingItems)
        }
    }
    
    var divider: some View {
        Rectangle()
            .frame(width: style.dividerWidth)
            .foregroundColor(style.dividerColor)
            .padding(.vertical, 5)
            .padding(.horizontal, style.itemSpacing)
    }
}

@available(iOS 16.0, *)
struct KeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbar(items: [
            KeyboardToolbarItem(systemName: "xmark.circle", callback: {}),
            KeyboardToolbarItem(systemName: "checkmark.circle", callback: {}),
            KeyboardToolbarItem(text: #"\"#, color: .red, callback: {}),
            KeyboardToolbarItem(text: "apple", color: .red, callback: {}),
        ], style: .standard)
            .padding(.vertical)
            .background(Color.secondary.opacity(0.3))
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)

        KeyboardToolbar(items: [
            KeyboardToolbarItem(text: "\\itemize", callback: {}),
            KeyboardToolbarItem(text: "\\sum", callback: {}),
            KeyboardToolbarItem(text: "\\epsilon", callback: {}),
        ], style: KeyboardToolbarStyle(
            backgroundColor: Color(UIColor.systemBackground),
            height: 70,
            itemSize: 17 - 4,
            itemSpacing: 5,
            dividerColor: Color(UIColor.systemGray4),
            dividerWidth: 1
        ))
        .padding(.vertical)
        .background(Color.secondary.opacity(0.3))
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        
        KeyboardToolbar(items: [
            KeyboardToolbarItem(text: "auto", callback: {}),
            KeyboardToolbarItem(text: "complete", callback: {}),
            KeyboardToolbarItem(text: "text", callback: {}),
            .dismissKeyboard,
        ], style: KeyboardToolbarStyle(
            backgroundColor: Color(UIColor.systemBackground),
            height: 45,
            itemSize: 16,
            itemSpacing: 5,
            dividerColor: Color(UIColor.systemGray4),
            dividerWidth: 1,
            dividerBetweenItems: true
        ))
        .frame(maxHeight: .infinity)
        .background(Color.secondary.opacity(0.3))
        
        KeyboardToolbar(items: [
            KeyboardToolbarItem(text: "auto", callback: {}),
            KeyboardToolbarItem(text: "complete", callback: {}),
            KeyboardToolbarItem(text: "text", callback: {}),
            .dismissKeyboard,
        ], style: .standard)
        .frame(maxHeight: .infinity)
        .background(Color.secondary.opacity(0.3))
    }
}
#endif
