//
//  File.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

extension NSMenuItem {
    static var openWindowAction: ((SceneID?, (any Codable & Hashable)?) -> Void)?
}
