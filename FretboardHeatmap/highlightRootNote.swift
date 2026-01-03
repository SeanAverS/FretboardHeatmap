//
//  highlightRootNote.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-02.
//
// Returns positions of the root note for each menu option
// Parameters
    // root: the selected chord/scale
    // string: the current string
    // fret: the current fret

import Foundation

struct HighlightRootNote {
    static func check(root: String, string: Int, fret: Int) -> Bool {
        switch root {
        case "G":
            return (string == 5 && fret == 3) || (string == 0 && fret == 3) || (string == 2 && fret == 0)
        default:
            return false
        }
    }
}
