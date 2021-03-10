import SwiftUI

internal struct KeyboardToolbar: View {
    var items: [KeyboardToolbarItem]
    var style: KeyboardToolbarStyle
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: style.itemSpacing) {
                ForEach(items) { item in
                    Button(action: item.callback, label: {
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(item.color)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 40, height: style.height)
                    .contentShape(Rectangle())
                }
            }
        }
        .frame(height: style.height)
        .background(style.backgroundColor)
    }
}

struct KeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbar(items: [KeyboardToolbarItem("xmark.circle", callback: {}), KeyboardToolbarItem("checkmark.circle", callback: {})], style: .standard)
    }
}
