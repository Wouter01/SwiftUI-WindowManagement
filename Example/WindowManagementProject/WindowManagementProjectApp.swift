//
//  WindowManagementProjectApp.swift
//  WindowManagementProject
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI
import WindowManagement

extension SceneID {
    static let firstWindowGroup = SceneID("firstWindowGroup")
}

@main
struct WindowManagementProjectApp: App {

    @NSApplicationDelegateAdaptor var delegate: AppDelegate

    init() {
        enableWindowSizeSaveOnQuit(true)
    }

    var body: some Scene {
        Group {
            WindowGroup(id: SceneID.firstWindowGroup.id) {
                ContentView()
            }
            .register(.firstWindowGroup)
            .windowButton(.closeButton, hidden: true)

            Settings {
                VStack {
                    Text("HEllo")
                }
                .frame(minWidth: 300, minHeight: 300)
            }
            .enableOpenWindow()
            
            NSDocumentGroup(for: CodeFileDocument.self) { document in
                Text(document.fileURL?.absoluteString ?? "")
            }
            .register(.document(CodeFileDocument.self))
            .movableByBackground(true)
            .windowButton(.miniaturizeButton, hidden: true)
        }
        .environment(\.controlSize, .large)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
//        NSApp.openSettings()
//        NSApp.openWindow(.firstWindowGroup)
    }
}
