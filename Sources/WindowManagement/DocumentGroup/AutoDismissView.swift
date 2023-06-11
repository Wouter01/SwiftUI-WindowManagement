//
//  AutoDismissView.swift
//
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

struct AutoDismissView: View {
    @Environment(\.dismiss) var dismissWindow

    var defaultAction: (() -> Void)?

    var body: some View {
        VStack {}
            .task {
                Task {
                    if let defaultAction {
                        defaultAction()
                    } else {
                        NSDocumentController.shared.openDocument(nil)
                    }
                }
                dismissWindow()
            }
    }
}
