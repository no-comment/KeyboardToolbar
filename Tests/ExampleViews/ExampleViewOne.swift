import SwiftUI
import KeyboardToolbar

struct ExampleViewOne: View {
    let toolbarItems: [KeyboardToolbarItem] = [
        .init("bold", callback: {}),
        .init("italic", callback: {}),
        .init("underline", callback: {}),
        .dismissKeyboard
    ]
    
    @State var text1 = ""
    @State var text2 = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $text1)
                    TextEditor(text: $text2)
                }
                Section {
                    Text("Keyboard toolbar with default styling, three toolbar items and the 'dismissKeyboard' preset.")
                }
            }
            .navigationTitle("Example 1")
            .keyboardToolbar(toolbarItems)
        }
    }
}

struct ExampleViewOne_Previews: PreviewProvider {
    static var previews: some View {
        ExampleViewOne()
    }
}
