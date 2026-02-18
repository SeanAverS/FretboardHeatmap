//
//  RootNotePositions.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-02.
//

import Foundation

/// Prepare root note positions for heatmap
/// - Parameters:
///   - root: Root note choice
///   - string: Current string
///   - fret: Current fret
/// - Returns: Note positions for right root
struct RootNotePositions {
    static func check(root: String, string: Int, fret: Int) -> Bool {
        return rootNotes[root]?[string]?.contains(fret) ?? false
    }
}

private let rootNotes: [String: [Int: [Int]]] = [
    "G": [0: [3], 1:[8], 2: [0, 12], 3: [5], 4: [10], 5: [3]],
    "D": [0: [10], 1: [3], 2: [7], 3: [0, 12], 4: [5], 5: [10]],
    "C": [0: [8], 1: [1], 2: [5], 3: [10], 4: [3], 5: [8]],
    "E": [0: [0, 12], 1: [5], 2: [9], 3: [2], 4: [7], 5: [0, 12]],
    "A": [0: [5], 1: [10], 2: [2], 3: [7], 4: [0, 12], 5: [5]]
]
