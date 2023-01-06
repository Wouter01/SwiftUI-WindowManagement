# SwiftUI-WindowManagement

The WindowManagement package allows you to control window behaviors of SwiftUI Scenes without doing weird tricks.
Views can also access the NSWindow through the Environment.

[Scene Modifiers](https://github.com/Wouter01/SwiftUI-WindowManagement/edit/main/README.md#available-scene-modifiers)

[View Modifiers](https://github.com/Wouter01/SwiftUI-WindowManagement/edit/main/README.md#available-scene-modifiers)

[Example](https://github.com/Wouter01/SwiftUI-WindowManagement/edit/main/README.md#example)

<img width="641" alt="Scherm­afbeelding 2023-01-06 om 21 45 28" src="https://user-images.githubusercontent.com/62355975/211096955-837f2ad0-f9dd-4cf6-88e4-6a8ba0acb9d1.png">

## Available Scene modifiers
#### register
This modifier enables the modification of the underlying `NSWindow` for this scene.
It should always be called before any of the other modifiers.
The identifier must be the same as the one set in the Scene initializer.
For the `Settings` Scene, use `registerSettingsWindow`.

```swift
func register(_ identifier: String)

func registerSettingsWindow()
```

#### movableByBackground
Indicates whether the window can be moved by clicking and dragging its background.
```swift
func movableByBackground(_ value: Bool)
```

#### movable
Indicates whether the view can be moved.
```swift
func movable(_ value: Bool)
```

#### styleMask
Apply a certain stylemask to the window.
Note that `NSWindow.StyleMask.titled` is always included, otherwise SwiftUI will crash.
```swift
func styleMask(_ styleMask: NSWindow.StyleMask)
```

#### windowButton
Indicated whether a window button should be enabled or not.
If disabled, the button will be greyed out but still visible.
The keyboard shortcut of the button won't be active.
Use `windowButton(_:hidden:)` to hide a window button.
```swift
func windowButton(_ button: NSWindow.ButtonType, enabled: Bool)
```

Indicated whether a window button should be hidden or not.
A hidden button can still be triggered with it's keyboard shortcut, e.g. Cmd+w for closing a window.
Use `windowButton(_:hidden:)` to disable a window button.
```swift
func windowButton(_ button: NSWindow.ButtonType, hidden: Bool)
```

#### collectionBehavior
Apply a certain collectionBehavior to the window.
```swift
func collectionBehavior(_ behavior: NSWindow.CollectionBehavior)
```

#### tabbingMode
Set the tabbingMode for the window.
If set to preferred, new windows will be opened as tabs.

```swift
func tabbingMode(_ mode: NSWindow.TabbingMode)
```

#### backgroundColor
Sets the background color of the window.
```swift
func backgroundColor(_ color: NSColor)
```

#### titlebarAppearsTransparent
Makes the titlebar transparent.
```swift
func titlebarAppearsTransparent(_ value: Bool)
```

#### disableResumeOnLaunch
This will stop windows from relaunching if they were open in the last active app state.
> Note: While this should work fine, I can't guarantee it.
```swift
func disableResumeOnLaunch()
```

## Available View modifiers
Inject the current window into the environment.
```swift
func injectWindow(_ identifier: String)
```
    
Inject the settings window into the environment.
```swift
func injectSettingsWindow()
```

Get the NSWindow from a View.
```swift
@Environment(\.window) var window
```

## Example

The following code shows the implementation of the window shown above.


```swift
import SwiftUI
import WindowManagement

@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup(id: "MyWindow") {
            ContentView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.regularMaterial)
            .injectWindow("MyWindow")
        }
        .register("MyWindow")
        .titlebarAppearsTransparent(true)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .movableByBackground(true)
        .backgroundColor(.systemGray.withAlphaComponent(0.001)) // Don't use .clear, causes glitches.
        .styleMask([.closable, .fullSizeContentView, .resizable])
        .windowButton(.miniaturizeButton, hidden: true)
        .windowButton(.zoomButton, hidden: true)
    }
}

struct ContentView: View {
    @Environment(\.window) var window
    var body: some View {
        Text("This windows identifier is \(window.identifier?.rawValue ?? "")")
        Button("Hide this window") {
            window.orderOut(nil)
        }
    }
}
```
