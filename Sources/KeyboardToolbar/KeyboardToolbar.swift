//
//  KeyboardToolbar.swift
//
//
//  Created by Cameron Shemilt on 09.03.21.
//

import SwiftUI

internal struct KeyboardToolbar: View {
    var items: [KeyboardToolbarItem]
    var backgroundColor: Color = Color(UIColor.systemGray4)
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 5) {
                ForEach(items) { item in
                    Button(action: item.callback, label: {
                        item.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(item.color)
                    }).buttonStyle(PlainButtonStyle())
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                }
            }
        }.frame(height: 40)
        .background(backgroundColor)
    }
}

struct KeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbar(items: [KeyboardToolbarItem("xmark.circle", callback: {}), KeyboardToolbarItem("checkmark.circle", callback: {})])
    }
}
