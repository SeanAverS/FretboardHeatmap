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
        currentMenu: NavMode?,
        dropdownChoice: String
    ) -> String {
        if currentMenu == .scales && dropdownChoice.hasPrefix("Min") || currentMenu == .chords && dropdownChoice.hasPrefix("Min") {
            return "\(root)m" // Minor Label toggle 
        }
        
        return root
    }
}
