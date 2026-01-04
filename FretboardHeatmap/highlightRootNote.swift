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
            return (string == 2 && fret == 0) ||
            (string == 0 && fret == 3) ||
            (string == 5 && fret == 3) ||
            (string == 3 && fret == 5) ||
            (string == 1 && fret == 8) ||
            (string == 4 && fret == 10) ||
            (string == 2 && fret == 12)
            
        case "D":
            return (string == 3 && fret == 0) ||
            (string == 1 && fret == 3) ||
            (string == 4 && fret == 5) ||
            (string == 2 && fret == 7) ||
            (string == 0 && fret == 10) ||
            (string == 5 && fret == 10) ||
            (string == 3 && fret == 12)
            
        case "C":
            return (string == 1 && fret == 1) ||
            (string == 4 && fret == 3) ||
            (string == 2 && fret == 5) ||
            (string == 0 && fret == 8) ||
            (string == 5 && fret == 8) ||
            (string == 3 && fret == 10)
            
        case "E":
            return (string == 3 && fret == 2) ||
            (string == 1 && fret == 5) ||
            (string == 4 && fret == 7) ||
            (string == 2 && fret == 9) ||
            (string == 0 && fret == 12) ||
            (string == 5 && fret == 12)
            
        case "A":
            return (string == 4 && fret == 0) ||
            (string == 2 && fret == 2) ||
            (string == 0 && fret == 5) ||
            (string == 5 && fret == 5) ||
            (string == 3 && fret == 7) ||
            (string == 1 && fret == 10) ||
            (string == 4 && fret == 12)
            
        default:
            return false
        }
    }
}
