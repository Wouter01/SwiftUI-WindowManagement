//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import AppKit

extension NSWindow {

    static var didSwizzle = false

    /// Always use an active appearance for the window.
    /// This allows SwiftUI Materials to have an always active state, instead of following the window key state.
    /// WARNING: Enabling this can have unwanted sideeffects.
    /// This option is enabled globally for all windows.
    public static var alwaysUseActiveAppearance = false

    static func swizzleAll() {
        if !didSwizzle {
            didSwizzle = true
            swizzleMethod(#selector(setter: NSWindow.identifier), #selector(NSWindow.setSwizzledIdentifier))
            swizzleMethod(#selector(setter: NSWindow.styleMask), #selector(NSWindow.setSwizzledStyleMask))

            if alwaysUseActiveAppearance {
                swizzleMethod(Selector(("hasKeyAppearance")), #selector(getter: NSWindow.hasKeyAppearanceOverride))
                swizzleMethod(Selector(("hasMainAppearance")), #selector(getter: NSWindow.hasKeyAppearanceOverride))
            }
        }
    }

    @objc var hasKeyAppearanceOverride: Bool {
        true
    }

    static func swizzleMethod(_ original: Selector, _ replacement: Selector) {

        let originalMethodSet = class_getInstanceMethod(self, original)
        let swizzledMethodSet = class_getInstanceMethod(self, replacement)

        method_exchangeImplementations(originalMethodSet!, swizzledMethodSet!)
    }
}
