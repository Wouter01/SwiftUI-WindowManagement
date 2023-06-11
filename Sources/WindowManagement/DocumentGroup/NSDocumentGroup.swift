//
//  NSDocumentGroup.swift
//
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

/// Creates a SwiftUI WindowGroup for an NSDocument class. This works similar to SwiftUI's DocumentGroup.
/// The defaultAction closure gets called when the user clicks the "+" button on a window tab bar.
@available(macOS 13.0, *)
public struct NSDocumentGroup<Content: View, NSDocumentType: NSDocument>: Scene {

    var type: NSDocumentType.Type
    var content: (NSDocumentType) -> Content
    var defaultAction: (() -> Void)?

    public init(for type: NSDocumentType.Type, content: @escaping (NSDocumentType) -> Content, defaultAction: (() -> Void)? = nil) {
        self.type = type
        self.content = content
        self.defaultAction = defaultAction
    }

    public var body: some Scene {
        let id = "document" + String(describing: type)
        WindowGroup(id: id, for: URL.self) { url in
            if let url = url.wrappedValue {
                let document = NSDocumentMapper.mapping[url]
                if let document = document?() as? NSDocumentType {
                    content(document)
                } else {
                    Text("Could not open document (\(url))")
                }
            } else {
                AutoDismissView(defaultAction: defaultAction)
            }
        }
    }
}
