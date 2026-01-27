//
//  LabelMapping.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-26.
//
//  Labels non-root fretboard notes and bottom menu

import Foundation

struct LabelMapping {
    
    static func getFretboardLabels(
        activeMenu: NavMode?,
        root: String,
        string: Int,
        fret: Int
    ) -> String {
        if activeMenu == .scales { // musical alphabet
            return NoteLabelMapping.getNoteName(string: string, fret: fret)
        } else { // finger positions
            return SelectedRootMapping.getFingerNumber(root: root, string: string, fret: fret)
        }
    }
    
    // switch bottom menu labels when necessary
    static func getBottomMenuLabels(
        for root: String,
        activeMenu: NavMode?,
        selectedScaleType: String
    ) -> String {
        if activeMenu == .scales && selectedScaleType.hasPrefix("Min") {
            return "\(root)m"
        }
        return root
    }
}

