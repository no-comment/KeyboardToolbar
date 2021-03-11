# KeyboardToolbar
A SwiftUI Toolbar for your iOS keyboard.

![KeyboardToolbarPreview](https://user-images.githubusercontent.com/31541782/110855742-0df94c80-82b7-11eb-955d-3fa352457dd1.gif)

You can find example files in `Tests/ExampleViews`

## Installation

Supports iOS 14.0+.

### Swift Package Manager

Add `https://github.com/cameronshemilt/KeyboardToolbar` to your [Package Dependencies](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

## Usage

The KeyboardToolbar can contain multiple `KeyboardToolbarItems` you provide.
You can additionally style the toolbar (size, color, padding etc.) via a `KeyboardToolbarStyle`.

```swift
import KeyboardToolbar

let toolbarItems: [KeyboardToolbarItem] = [
    .init("bold", callback: {}),
    .init("italic", callback: {}),
    .init("underline", callback: {}),
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

Use by attaching `.keyboardToolbar(...)` to the outermost part of your View.

### KeyboardToolbarItem

| **Parameter** | **Type**               | **Optional** | **Description**                                              |
| ------------- | ---------------------- | ------------ | ------------------------------------------------------------ |
| `image`       | `Image`                | No           | The image/icon of the toolbar icon. Convenience initializers exist for *systemName* and *name* |
| `color`       | `Color`                | Yes          | Color of the image/icon                                      |
| `isFixed`     | `KeyboardToolbarEdge?` | Yes          | Whether the item should be sticky or not. Possible values: `nil`, `.leading` or `.trailing`. |
| `callback`    | `() -> Void`           | No           | Action the item should perform when pressed                  |

#### Presets

- `.dismissKeyboard`: A button fixed to the right side that will dismiss the keyboard when tapped.

### KeyboardToolbarStyle

| **Parameter**     | **Type**  | Optional | **Description**                                              |
| ----------------- | --------- | -------- | ------------------------------------------------------------ |
| `backgroundColor` | `Color`   | Yes      | The background color of the toolbar.                         |
| `height`          | `CGFloat` | Yes      | Height of the toolbar.                                       |
| `itemSize`        | `CGFloat` | Yes      | Size of the toolbar items.                                   |
| `itemSpacing`     | `CGFloat` | Yes      | Spacing between the toolbar items.                           |
| `dividerColor`    | `Color`   | Yes      | Color of the divider above the toolbar, as well as the dividers between the fixed and not fixed items. |
| `dividerWidth`    | `CGFloat` | Yes      | Width of the dividers.                                       |

#### Presets

- `.standard`
- `.contrast`
