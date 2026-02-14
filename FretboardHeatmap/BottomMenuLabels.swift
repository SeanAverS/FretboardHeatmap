//
//  BottomMenuLabels.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-02-09.
//
//  Return Bottom Menu Root Labels

import Foundation

struct BottomMenuLabels {
    static func getLabels (
        for root: String,
        activeMenu: NavMode?,
        dropdownChoice: String
    ) -> String {
        if activeMenu == .scales && dropdownChoice.hasPrefix("Min") || activeMenu == .chords && dropdownChoice.hasPrefix("Min") {
            return "\(root)m" // Minor Label toggle
        }
        
        return root
    }
}
