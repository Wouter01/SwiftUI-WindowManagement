//
//  ContentView.swift
//  WindowManagementProject
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
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
