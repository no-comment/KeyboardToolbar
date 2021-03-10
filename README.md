# KeyboardToolbar
A SwiftUI Toolbar for your iOS keyboard.

## Installation

Supports iOS 14.0+.

### Swift Package Manager

File -> Swift Packages -> Add Package Dependency and use the URL `https://github.com/cameronshemilt/KeyboardToolbar`.

## Usage

The KeyboardToolbar contains ToolbarItems you provide.

```swift
import KeyboardToolbar

let toolbarItems = [
    KeyboardToolbarItem("bold", callback: {}),
    KeyboardToolbarItem("italic", callback: {}),
    .dismissKeyboard
]

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        Form {
            TextField("Input", text: $text)
        }
        .keyboardToolbar(toolbarItems)
    }
}
```

## API

### KeyboardToolbar

| **Parameter** | **Type**                | **Optional** | **Description**                                              |
| ------------- | ----------------------- | ------------ | ------------------------------------------------------------ |
| `items`       | `[KeyboardToolbarItem]` | No           | All of the KeyboardToolbarItems you want the Toolbar to contain. |
| `style`       | `KeyboardToolbarStyle`  | Yes          | The styling of the toolbar.                                  |

Use by attaching `.keyboardToolbar()` to the outermost part of your View.

### KeyboardToolbarItem

| **Parameter** | **Type**               | **Optional** | **Description**                                              |
| ------------- | ---------------------- | ------------ | ------------------------------------------------------------ |
| `image`       | `Image`                | No           | The image/icon of the toolbar icon. Convenience initializers exist for systemName and name |
| `color`       | `Color`                | Yes          | Color of the image/icon                                      |
| `isFixed`     | `KeyboardToolbarEdge?` | Yes          | Wether the item should be sticky or not. Possible values: `nil`, `.leading` or `.trailing`. |
| `callback`    | `() -> Void`           | No           | Action the item should perform when pressed                  |

#### Presets

- `.dismissKeyboard`: A button fixed to the right side that will dismiss the keyboard when tapped.

### KeyboardToolbarStyle

| **Parameter**     | **Type**  | Optional | **Description**                                              |
| ----------------- | --------- | -------- | ------------------------------------------------------------ |
| `backgroundColor` | `Color`   | Yes      | The background color of the toolbar.                         |
| `dividerColor`    | `Color`   | Yes      | Color of the divider above the toolbar, as well as the dividers between the fixed and not fixed items. |
| `height`          | `CGFloat` | Yes      | Height of the toolbar.                                       |
| `itemSize`        | `CGFloat` | Yes      | Size of the toolbar items.                                   |
| `itemSpacing`     | `CGFloat` | Yes      | Spacing between the toolbar items.                           |

#### Presets

- `.standard`
- `.contrast`