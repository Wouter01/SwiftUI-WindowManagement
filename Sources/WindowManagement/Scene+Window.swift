//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import SwiftUI

public extension Scene {
    func register(with identifier: String) -> some Scene {
        NSWindow.swizzleAll()
        WM.currentIdentifier = identifier
        WM.modifications[identifier] = WindowModifications()
        print("Registered... \(String(describing: Self.self))")
        return self
    }

    func movableByBackground(_ value: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.movableByBackground = value
        return self
    }

    func movable(_ value: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.movable = value
        return self
    }

    func styleMask(_ styleMask: NSWindow.StyleMask) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.styleMask = styleMask
        //        currentWindow?.styleMask = styleMask
        return self
    }

    func windowButton(_ button: NSWindow.ButtonType, enabled: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.windowButtonsEnabled[button, default: .init()].enabled = enabled
        return self
    }

    func windowButton(_ button: NSWindow.ButtonType, hidden: Bool) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.windowButtonsEnabled[button, default: .init()].isHidden = hidden
        return self
    }

    func collectionBehavior(_ behavior: NSWindow.CollectionBehavior) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.collectionBehavior = behavior
        return self
    }

    func tabbingMode(_ mode: NSWindow.TabbingMode) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.tabbingMode = mode
        return self
    }

    func backgroundColor(_ color: NSColor) -> some Scene {
        WM.modifications[WM.currentIdentifier]?.backgroundColor = color
        return self
    }

    func disableResumeOnLaunch() -> some Scene {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            if key.starts(with: "NSWindow Frame \(WM.currentIdentifier)-AppWindow") {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        return self
    }
}
