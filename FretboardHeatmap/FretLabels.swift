//
//  FretLabels.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-26.
//

import Foundation

///  Labels non-root fretboard notes(for scales) and finger numbers(for chords)
struct FretLabels {
    
    /// Prepare fret labels for heatmap
    /// - Parameters:
    ///   - activeMenu: Top menu choice
    ///   - root: Root note choice
    ///   - dropdownChoice: Top menu dropdown choice
    ///   - string: The current string
    ///   - fret: The current fret
    ///  - Returns: Non-root fretboard notes (for scales) and finger numbers(for chords)
    static func getLabels(
        activeMenu: menuChoice?,
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
