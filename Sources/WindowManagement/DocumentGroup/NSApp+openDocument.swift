//
//  NSApp+openDocument.swift
//
//
//  Created by Wouter Hennen on 11/06/2023.
//

import AppKit

public extension SceneID {

    static func document<Document: NSDocument>(_ type: Document.Type) -> SceneID {
        SceneID("document" + String(describing: type))
    }
}

public extension NSApplication {
    /// Open a new NSDocumentGroup Window with given type.
    func openDocument<Document: NSDocument>(_ type: Document.Type, _ document: Document) -> NSWindow? {
        guard let fileURL = document.fileURL else { return nil }
        NSDocumentMapper.mapping[fileURL] = { [weak document] in document }
        NSApp.openWindow(.document(type), value: fileURL)

        let window = NSApp
            .windows
            .filter { $0.identifier?.rawValue.starts(with: "document" + String(describing: Document.self)) ?? false }
            .filter { $0.windowController?.document == nil }
            .first

        window?.title = fileURL.absoluteString
        window?.representedURL = fileURL
        window?.identifier = .init(fileURL.absoluteString)

        return window
    }

    /// Open a new NSDocumentGroup Window.
    func openDocument<Document: NSDocument>(_ document: Document) -> NSWindow? {
        openDocument(Document.self, document)
    }
}
