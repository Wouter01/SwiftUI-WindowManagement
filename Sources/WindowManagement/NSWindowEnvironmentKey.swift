//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import SwiftUI

public extension EnvironmentValues {
    var window: NSWindowEnvironmentKey.Value {
        get { self[NSWindowEnvironmentKey.self] }
        set { self[NSWindowEnvironmentKey.self] = newValue }
    }
}

public struct NSWindowEnvironmentKey: EnvironmentKey {
    public static var defaultValue = NSWindow()
}
