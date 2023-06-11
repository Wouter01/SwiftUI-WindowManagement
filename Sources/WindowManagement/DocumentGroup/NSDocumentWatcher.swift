//
//  File.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

enum NSDocumentMapper {
    static var mapping: [URL: () -> NSDocument?] = [:]
}
