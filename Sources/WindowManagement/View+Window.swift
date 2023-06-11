//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import SwiftUI

public extension View {
    /// Inject the settings window into the environment.
    func injectSettingsWindow() -> some View {
        if #available(macOS 13, *) {
            return self.modifier(Injectwindow(identifier: "com_apple_SwiftUI_Settings_window"))
        } else {
            return self.modifier(Injectwindow(identifier: "SwiftUIWindow"))
        }
    }

    /// Inject the current window into the environment.
    func injectWindow(_ identifier: String) -> some View {
        return self.modifier(Injectwindow(identifier: identifier))
    }

    /// Inject the current window into the environment.
    func injectWindow(_ identifier: SceneID) -> some View {
        return self.modifier(Injectwindow(identifier: identifier.id))
    }
}

struct Injectwindow: ViewModifier {
    var identifier: String
    @State var window = NSWindow()

    func body(content: Content) -> some View {
        content
            .environment(\.window, window)
            .task {
                if window.identifier == nil {
                    window = WM.availableWindows.first { $0.identifier?.rawValue.starts(with: identifier) ?? false } ?? NSWindow()
                    WM.availableWindows = Array(WM.availableWindows.dropFirst())
                }
            }
    }
}
