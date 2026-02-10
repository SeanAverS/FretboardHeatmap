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
        dropdownChoice: String,
        string: Int,
        fret: Int
    ) -> String {
        if activeMenu == .scales { // musical alphabet
            return NoteAlphabet.getNoteName(string: string, fret: fret)
        } else { // finger positions
            return FretPositions.getFingerNumber(dropdownChoice: dropdownChoice, root: root, string: string, fret: fret)
        }
    }
}
