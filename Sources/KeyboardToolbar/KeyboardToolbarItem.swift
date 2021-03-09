//
//  KeyboardToolbarItem.swift
//  
//
//  Created by Cameron Shemilt on 09.03.21.
//

import SwiftUI

struct KeyboardToolbarItem: Identifiable {
    var id: UUID = UUID()
    var image: Image
    var callback: () -> Void
    var color: Color
    
    init(_ image: Image, color: Color = .accentColor, callback: @escaping () -> Void) {
        self.image = image
        self.callback = callback
        self.color = color
    }
    
    init(_ systemName: String, color: Color = .accentColor, callback: @escaping () -> Void) {
        self.init(Image(systemName: systemName), color: color, callback: callback)
    }
    
    init(name: String, color: Color = .accentColor, callback: @escaping () -> Void) {
        self.init(Image(name), color: color, callback: callback)
    }
}
