//
//  selectedRootMapping.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2025-12-26.
//
//  Returns fret positions of the selected chord or scale root
//  Parameters
    // root: the selected chord/scale
    // mode: current menu

import Foundation

struct SelectedRootMapping {
    
    static func getFretMap(for root: String, mode: String?) -> [Int: Int] {
        if mode == "Chords" {
            switch root {
            case "G":  return [0: 3, 4: 2, 5: 3]
            case "D":  return [0: 2, 1: 3, 2: 2]
            case "C":  return [1: 1, 3: 2, 4: 3]
            case "E":  return [2: 1, 3: 2, 4: 2]
            case "A":  return [1: 2, 2: 2, 3: 2]
            case "Am": return [1: 1, 2: 2, 3: 2]
            default:   return [:]
            }
        }
        return [:]
    }
}
