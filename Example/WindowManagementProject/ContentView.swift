//
//  ContentView.swift
//  WindowManagementProject
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI
import WindowManagement

struct ContentView: View {
    @Environment(\.window) var window
    var body: some View {
        VStack {
            Text("Window title:", window.title)
            Button("Open Document (only .h file supported)") {
                NSDocumentController.shared.openDocument(nil)
            }

            Button("Open Settings") {
                NSApp.openSettings()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
