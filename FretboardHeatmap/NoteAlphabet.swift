//
//  NoteAlphabet.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-14.
//

import Foundation

/// Prepare musical notes for FretLabels
struct NoteAlphabet {
    private static let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    private static let openStringIndex = [4, 11, 7, 2, 9, 4] // High E to Low E
    
    /// Determine musical note for current position
    ///
    /// Formula: `(Open String Position + Current Fret) % 12`
    /// - Modulo keeps the value inside notes[]
    ///
    /// - Parameters:
    ///    - string: The current string
    ///    - fret: The current fret
    /// - Returns: Musical note for current position
    static func getNoteName(string: Int, fret: Int) -> String {
        guard string >= 0 && string < openStringIndex.count else { return "" }
        
        let notePosition = (openStringIndex[string] + fret) % 12
        return notes[notePosition]
    }
}
