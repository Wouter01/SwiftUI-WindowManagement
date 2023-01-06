import SwiftUI

struct WM {
    static var currentIdentifier: String = ""
    static var availableWindows: [NSWindow] = []
    static var modifications: [String: WindowModifications] = [:]
    static var didSwizzle = false
}

struct WindowModifications {
    var styleMask: NSWindow.StyleMask?
    var windowButtonsEnabled: [NSWindow.ButtonType: WindowButton] = [:]
    var collectionBehavior: NSWindow.CollectionBehavior?
    var movableByBackground: Bool?
    var movable: Bool?
    var tabbingMode: NSWindow.TabbingMode?
    var backgroundColor: NSColor?

    struct WindowButton {
        var enabled = true
        var isHidden = false
    }
}
