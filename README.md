# SwiftUI-WindowManagement

The WindowManagement package allows you to control window behaviors of SwiftUI Scenes without doing weird tricks.
Views can also access the NSWindow through the Environment.

<img width="602" alt="image" src="https://github.com/Wouter01/SwiftUI-WindowManagement/assets/62355975/fa1db759-a21b-41b8-86a1-9c633a4bdfa8">


## Notice
> This package uses and modifies some internals of SwiftUI. As SwiftUI changes frequently, implementations might break.

> Note: DocumentGroup is not supported (yet)

## Compatibility
- macOS 12.0 (Untested, but should work)
- macOS 13.0
- macOS 14.0

## Opening SwiftUI Windows from anywhere in your app.
Using SwiftUI windows can be difficult when parts of your app rely on AppKit types. For example, you can't open a SwiftUI window from an `AppDelegate`. This package adds some functions to `NSApp` to allow this kind of behavior.

#### Usage
First, define a SceneID for each SwiftUI scene:
```swift
extension SceneID {
    static let myWindow = SceneID("myWindow")
}
```
Important: you must add `.enableOpenWindow()` to one scene (only one is required) to enable the functionality.
```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup(id: SceneID.myWindow.id) {
            ...
        }
        .enableOpenWindow()
    }
}
```
You can open a window by calling the following function:
```swift
func applicationDidFinishLaunching(_ notification: Notification) {
    NSApp.openWindow(.myWindow)
}
```

You can also open a SwiftUI Settings window (also works on macOS Sonoma):
```swift
func applicationDidFinishLaunching(_ notification: Notification) {
    NSApp.openSettings()
}
```

## Passing an Environment Value to multiple Scenes
```swift
var body: some Scene {
    Group {
        WindowGroup {
            ...
        }

        Settings {
            ...
        }
        
        NSDocumentGroup(for: ...) { _ in
            ...
        }
    }
    .environment(\.controlSize, .large)
}
```

## Scene Window UI Modifiers
#### register
This modifier enables the modification of the underlying `NSWindow` for this scene.
It should always be called before any of the other modifiers.
The identifier must be the same as the one set in the Scene initializer.
For the `Settings` Scene, use `registerSettingsWindow`.

```swift
func register(_ identifier: String)

func register(_ identifier: SceneID)

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

#### disableRestoreOnLaunch
This will stop windows from relaunching if they were open in the last active app state.
> Note: While this should work fine, I can't guarantee it.
```swift
func disableRestoreOnLaunch()
```

#### transition
Configure the NSWindow.AnimationBehavior for the Scene
```swift
func transition(_ transition: NSWindow.AnimationBehavior)
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

## NSDocumentGroup
NSDocumentGroup is an alternative to SwiftUI's documentgroup. It allows you to use a SwiftUI Window with an NSDocument. This is useful for cases where you need SwiftUI (for example, to make `.focusedValue` work), but `FileDocument` or `ReferenceFileDocument` are not meeting your requirements. One of the issues I ran into with these types is that they become slow when opening large folders (for example, a node_modules folder). Using an NSDocument allows you to optimize this.

#### Usage
See the example folder for a working sample project.

First, create a NSDocument class (make sure to add the filetype to the project config).
Override the `makeWindowControllers()` type and open a new SwiftUI window by calling `openDocument`.
```swift
override func makeWindowControllers() {
    if let window = NSApp.openDocument(self), let windowController = window.windowController {
        addWindowController(windowController)
    }
}
```
Add a new NSDocumentGroup Scene to your app. The scene provides a reference to the opened NSDocument.
```swift
NSDocumentGroup(for: CodeFileDocument.self) { document in
    Text(document.fileURL?.absoluteString ?? "")
}
```

## Extras

Make SwiftUI Materials always active
> Note: Set this once in the initializer of your implementation of the `App` protocol
```swift
NSWindow.alwaysUseActiveAppearance = true
```

## Example
An example project can be found in the project repository.
