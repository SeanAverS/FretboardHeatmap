//
//  BottomMenuLabels.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-02-09.
//

import Foundation

// Provides the bottom label menus
struct BottomMenuLabels {
    
    /// Prepare bottom menu labels
    /// - Parameters:
    ///   - root: Root note choice
    ///   - activeMenu: Top menu choice
    ///   - dropdownChoice: Top menu dropdown choice
    /// - Returns: The right bottom menu labels
    static func getLabels (
        for root: String,
        activeMenu: menuChoice?,
        dropdownChoice: String
    ) -> String {
        if minorKeySelected(activeMenu: activeMenu, dropdownChoice: dropdownChoice) {
            return "\(root)m"
        }
        return root
    }
    
    /// Prepare bottom menu minor labels
    /// - Parameters:
    ///   - activeMenu: Top menu choice
    ///   - dropdownChoice: Top menu dropdown choice
    /// - Returns: Minor labels (if needed)
    private static func minorKeySelected(activeMenu: menuChoice?, dropdownChoice: String) -> Bool {
            guard let menu = activeMenu else { return false }
            
            let isMinor = dropdownChoice.hasPrefix("Min")
            
            return (menu == .scales || menu == .chords) && isMinor
        }
}
