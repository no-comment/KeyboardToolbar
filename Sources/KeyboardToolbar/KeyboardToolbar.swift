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
            
            Divider()
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(style.dividerColor)
            
            scrollingItemsView
            
            Divider()
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(style.dividerColor)
            
            trailingItemsView
        }
        .frame(height: style.height)
        .padding(.horizontal, 10)
        .background(style.backgroundColor)
    }
    
    var leadingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            ForEach(leadingItems) { item in
                Button(action: item.callback, label: {
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: style.itemSize, height: style.itemSize)
                        .foregroundColor(item.color)
                })
                .buttonStyle(PlainButtonStyle())
                .frame(height: style.height)
                .contentShape(Rectangle())
            }
        }
    }
    
    var scrollingItemsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: style.itemSpacing) {
                ForEach(scrollingItems) { item in
                    Button(action: item.callback, label: {
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: style.itemSize, height: style.itemSize)
                            .foregroundColor(item.color)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: style.height)
                    .contentShape(Rectangle())
                }
            }
        }
    }
    
    var trailingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            ForEach(trailingItems) { item in
                Button(action: item.callback, label: {
                    item.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: style.itemSize, height: style.itemSize)
                        .foregroundColor(item.color)
                })
                .buttonStyle(PlainButtonStyle())
                .frame(height: style.height)
                .contentShape(Rectangle())
            }
        }
    }
}

struct KeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbar(items: [KeyboardToolbarItem("xmark.circle", callback: {}), KeyboardToolbarItem("checkmark.circle", callback: {})], style: .standard)
    }
}
