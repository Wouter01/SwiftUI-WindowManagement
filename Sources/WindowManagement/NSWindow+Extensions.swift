//
//  File.swift
//  
//
//  Created by Wouter Hennen on 06/01/2023.
//

import AppKit

extension NSWindow {

    @objc func setSwizzledStyleMask(_ newValue: StyleMask) {
        if let id = identifier {
            let key = id.rawValue.prefix(while: { $0 != "-"})
            let value = WM.modifications[String(key)]
            if let styleMask = value?.styleMask {
                self.setSwizzledStyleMask(styleMask.union(newValue.intersection(.fullScreen)))
            } else {
                self.setSwizzledStyleMask(newValue)
            }
        } else {
            self.setSwizzledStyleMask(newValue)
        }
    }

    @objc func setSwizzledIdentifier(_ newValue: NSUserInterfaceItemIdentifier?) {
        self.setSwizzledIdentifier(newValue)

        if !WM.availableWindows.contains(self) {
            WM.availableWindows.append(self)
        }

        if let id = newValue {

            let key = id.rawValue.prefix(while: { $0 != "-"})

            let value = WM.modifications[String(key)]

            guard let value else { return }

            if let styleMask = value.styleMask {
                self.setSwizzledStyleMask(styleMask.union(.titled)) // .titled is required for SwiftUI
            }

            if let behavior = value.collectionBehavior {
                collectionBehavior = behavior
            }

            if let movableByBackground = value.movableByBackground {
                isMovableByWindowBackground = movableByBackground
            }

            if let movable = value.movable {
                isMovable = movable
            }

            if let tabbingMode = value.tabbingMode {
                self.tabbingMode = tabbingMode
            }

            if let bgColor = value.backgroundColor {
                self.backgroundColor = bgColor
            }

            if let transparent = value.titlebarAppearsTransparent {
                self.titlebarAppearsTransparent = transparent
            }

            if let disableRestore = value.disableRestoreOnLaunch {
                self.isRestorable = !disableRestore
            }

            value.windowButtonsEnabled.forEach {
                standardWindowButton($0)?.isHidden = $1.isHidden
                standardWindowButton($0)?.isEnabled = $1.enabled
            }
        }
    }
}
