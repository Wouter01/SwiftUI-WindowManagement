//
//  NSApp+openWindow.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

public extension NSApplication {
    /// Open a SwiftUI Window with given ID.
    func openWindow(_ id: SceneID) {
        NSMenuItem.openWindowAction?(id, nil)
    }

    /// Open a SwiftUI Window with given ID and value.
    func openWindow(_ id: SceneID, value: any Codable & Hashable) {
        NSMenuItem.openWindowAction?(id, value)
    }

    /// Open a SwiftUI Window with given value.
    func openWindow(value: any Codable & Hashable) {
        NSMenuItem.openWindowAction?(nil, value)
    }

    /// Open the SwiftUI Settings window.
    func openSettings() {
        let eventSource = CGEventSource(stateID: .hidSystemState)
        let keyCommand = CGEvent(keyboardEventSource: eventSource, virtualKey: 0x2B, keyDown: true)
        guard let keyCommand else { return }

        keyCommand.flags = .maskCommand
        let event = NSEvent(cgEvent: keyCommand)
        guard let event else { return }

        NSApp.sendEvent(event)
    }
}
