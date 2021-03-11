import SwiftUI
import KeyboardToolbar

struct ExampleViewThree: View {
    @State var toolbarItems: [KeyboardToolbarItem] = []
    
    @State var text1 = ""
    @State var text2 = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $text1, onEditingChanged: textFieldChanged)
                    TextField("Message", text: $text2, onEditingChanged: textField2Changed)
                }
                
                Section {
                    Text("Keyboard toolbar with multiple TextFields that have different toolbar items.")
                }
            }
            .navigationTitle("Example 3")
            .keyboardToolbar(toolbarItems, style: .contrast)
        }
    }
    
    func textFieldChanged(_ val: Bool) {
        toolbarItems = [.dismissKeyboard]
    }
    
    func textField2Changed(_ val: Bool) {
        toolbarItems = [
            .init("bold", callback: {}),
            .init("italic", callback: {}),
            .init("underline", callback: {}),
            .dismissKeyboard
        ]
    }
}

struct ExampleViewThree_Previews: PreviewProvider {
    static var previews: some View {
        ExampleViewThree()
    }
}
