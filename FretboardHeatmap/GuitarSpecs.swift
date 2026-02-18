//
//  GuitarSpecs.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-25.
//

import Foundation

///  Provides data for guitar frets, strings, and root notes
struct GuitarSpecs {
    // guitar frets
    static let frets: [CGFloat] = [90, 85, 80, 75, 71, 67, 63, 60, 56, 53, 50, 47]
    
    // guitar strings
    static let strings: [CGFloat] = [0.8, 1.2, 1.8, 2.5, 3.2, 4.0]
    
    // root notes
    static let roots = ["G", "D", "C", "E", "A"]
}

