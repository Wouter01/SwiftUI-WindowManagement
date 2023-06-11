//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import SwiftUI

public extension Scene {

    /// Registers a scene to be modified by the following scene modifiers.
    /// The identifier should be the same as in the Scene initializer.
    /// This modifier should be called before other modifiers of this package.
    func register(_ identifier: String) -> some Scene {
        WM.currentIdentifier = identifier
        WM.modifications[identifier] = WindowModifications()
        return self
    }

    /// Registers a scene to be modified by the following scene modifiers.
    /// The identifier should be the same as in the Scene initializer.
    /// This modifier should be called before other modifiers of this package.
    func register(_ identifier: SceneID) -> some Scene {
        WM.currentIdentifier = identifier.id
        WM.modifications[identifier.id] = WindowModifications()
        return self
    }

    /// Registers the settings scene to be modified by the following scene modifiers.
    /// The identifier should be the same as in the Scene initializer.
    /// This modifier should be called before other modifiers of this package.
    func registerSettingsWindow() -> some Scene {
        WM.currentIdentifier = "com_apple_SwiftUI_Settings_window"
        WM.modifications[WM.currentIdentifier] = WindowModifications()
        return self
    }

    /// Indicates whether the window can be moved by clicking and dragging its background.
    func movableByBackground(_ value: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.movableByBackground = value
        return self
    }

    /// Indicates whether the view can be moved.
    func movable(_ value: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.movable = value
        return self
    }

    /// Apply a certain stylemask to the window.
    /// Note that `NSWindow.StyleMask.titled` is always included, otherwise SwiftUI will crash.
    func styleMask(_ styleMask: NSWindow.StyleMask) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.styleMask = styleMask
        return self
    }

    /// Indicated whether a window button should be enabled or not.
    /// If disabled, the button will be greyed out but still visible.
    /// The keyboard shortcut of the button won't be active.
    /// Use `windowButton(_:hidden:)` to hide a window button.
    func windowButton(_ button: NSWindow.ButtonType, enabled: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.windowButtonsEnabled[button, default: .init()].enabled = enabled
        return self
    }

    /// Indicated whether a window button should be hidden or not.
    /// A hidden button can still be triggered with it's keyboard shortcut, e.g. Cmd+w for closing a window.
    /// Use `windowButton(_:hidden:)` to disable a window button.
    func windowButton(_ button: NSWindow.ButtonType, hidden: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.windowButtonsEnabled[button, default: .init()].isHidden = hidden
        return self
    }

    /// Apply a certain collectionBehavior to the window.
    func collectionBehavior(_ behavior: NSWindow.CollectionBehavior) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.collectionBehavior = behavior
        return self
    }

    /// Set the tabbingMode for the window.
    /// If set to preferred, new windows will be opened as tabs.
    func tabbingMode(_ mode: NSWindow.TabbingMode) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.tabbingMode = mode
        return self
    }

    /// Sets the background color of the window.
    func backgroundColor(_ color: NSColor) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.backgroundColor = color
        return self
    }

    /// Makes the titlebar transparent.
    func titlebarAppearsTransparent(_ value: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.titlebarAppearsTransparent = value
        return self
    }

    /// This will stop windows from relaunching if they were open in the last active app state.
    func disableRestoreOnLaunch() -> some Scene {
        WM.modifications[WM.currentIdentifier]?.disableRestoreOnLaunch = true
        return self
    }
}
