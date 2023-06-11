//
//  File.swift
//  
//
//  Created by Wouter Hennen on 11/06/2023.
//

import SwiftUI

public extension App {

    /// Enable or disable window restoring after quitting. This is the same behavior as when an app is restored after reboot or force quit.
    func enableWindowSizeSaveOnQuit(_ enabled: Bool = true) {
        UserDefaults.standard.setValue(enabled, forKey: "NSQuitAlwaysKeepsWindows")
    }
}
