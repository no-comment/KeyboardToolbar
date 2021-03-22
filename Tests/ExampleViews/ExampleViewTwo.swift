import SwiftUI
import KeyboardToolbar

struct ExampleViewTwo: View {
    let toolbarItems: [KeyboardToolbarItem] = [
        .init(systemName: "bold", color: .white, callback: {}),
        .init(systemName: "italic", color: .white, callback: {}),
        .init(systemName: "underline", color: .white, callback: {}),
        .dismissKeyboard
    ]
    
    let style = KeyboardToolbarStyle(backgroundColor: .black,
                                     height: 50,
                                     itemSize: 25,
                                     itemSpacing: 20,
                                     dividerColor: .gray,
                                     dividerWidth: 2)
    
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
                    Text("Keyboard toolbar with custom styling and sizing.")
                }
            }
            .navigationTitle("Example 2")
            .keyboardToolbar(toolbarItems, style: style)
        }
    }
}

struct ExampleViewTwo_Previews: PreviewProvider {
    static var previews: some View {
        ExampleViewTwo()
    }
}
