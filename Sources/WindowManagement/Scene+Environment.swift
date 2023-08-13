//
//  File.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

public extension SwiftUI.Scene {
    @inlinable
    func modifier<T>(_ modifier: T) -> ModifiedContent<Self, T> {
        return .init(content: self, modifier: modifier)
    }
}
