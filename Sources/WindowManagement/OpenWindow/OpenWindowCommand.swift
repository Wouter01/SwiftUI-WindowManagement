//
//  File.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

@available(macOS 13.0, *)
struct OpenWindowCommand: Commands {
    @Environment(\.openWindow) var openWindow

    public var body: some Commands {
        CommandGroup(after: .windowArrangement) {
            Divider()
            .hidden()
            .task {
                NSMenuItem.openWindowAction = { scene, value in
                    switch (scene, value) {
                    case (.some(let id), .none):
                        openWindow(id: id.id)
                    case (.none, .some(let data)):
                        openWindow(value: data)
                    case let (.some(id), .some(data)):
                        openWindow(id: id.id, value: data)
                    default:
                        break
                    }
                }
            }
        }
    }
}

public extension Scene {
    /// Required to enable window opening from NSApp. Call this method only once, from one scene.
    @available(macOS 13.0, *)
    func enableOpenWindow() -> some Scene {
        commands {
            OpenWindowCommand()
        }
    }
}
