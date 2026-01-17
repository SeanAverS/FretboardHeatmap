//
//  NoteLabelMapping.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-14.
//
//  Returns the note name of each fret for the selected chord or scale root
//  Parameters
    // string: the current string
    // fret: the current fret 

import Foundation

struct NoteLabelMapping {
    private static let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    private static let stringOffsets = [4, 11, 7, 2, 9, 4] // High E to Low E
    
    static func getNoteName(string: Int, fret: Int) -> String {
        guard string >= 0 && string < stringOffsets.count else { return "" }
        
        let noteIndex = (stringOffsets[string] + fret) % 12 // (string position + current fret)
        return notes[noteIndex]
    }
}

// Explanation
    // stringOffsets[]: current Open String notes[i], i.e just strumming the string itself
    // stringOffsets[string]: string[i] from ContentView, i.e map musical note to current string
    // (stringOffsets[string] + fret) % 12: always stays within notes[i]
