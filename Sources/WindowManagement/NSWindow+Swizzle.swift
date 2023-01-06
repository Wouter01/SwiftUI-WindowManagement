//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import AppKit

extension NSWindow {

    static var didSwizzle = false

    static func swizzleAll() {
        if !didSwizzle {
            didSwizzle = true
            swizzleMethod(#selector(setter: NSWindow.identifier), #selector(NSWindow.setSwizzledIdentifier))
            swizzleMethod(#selector(setter: NSWindow.styleMask), #selector(NSWindow.setSwizzledStyleMask))
        }
    }

    static func swizzleMethod(_ original: Selector, _ replacement: Selector) {

        let originalMethodSet = class_getInstanceMethod(self, original)
        let swizzledMethodSet = class_getInstanceMethod(self, replacement)

        method_exchangeImplementations(originalMethodSet!, swizzledMethodSet!)
    }
}
