//
//  CodeFileDocument.swift
//  WindowManagementProject
//
//  Created by Wouter Hennen on 11/06/2023.
//

import AppKit
import WindowManagement

@objc(CodeFileDocument)
final class CodeFileDocument: NSDocument {

    override nonisolated func read(from data: Data, ofType typeName: String) throws {

    }

    override func makeWindowControllers() {
        if let window = NSApp.openDocument(self), let windowController = window.windowController {
            addWindowController(windowController)
        }
    }
}
