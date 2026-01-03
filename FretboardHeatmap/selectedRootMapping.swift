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
    
    static func getFretMap(for root: String, mode: String?) -> [Int: [Int]] {
        if mode == "Chords" {
            switch root { // [string: [fret]
            case "G":  return [0: [3], 4: [2], 5: [3]]
            case "D":  return [0: [2], 1: [3], 2: [2]]
            case "C":  return [1: [1], 3: [2], 4: [3]]
            case "E":  return [2: [1], 3: [2], 4: [2]]
            case "A":  return [1: [2], 2: [2], 3: [2]]
            default:   return [:]
            }
        }
        
        if mode == "Scales" {
            switch root { // [string: [fret1,fret2..] 
            case "G":
                return [0: [0, 3], 1: [0, 2], 2: [0, 2], 3: [0, 2], 4: [0, 2], 5: [0, 3]]
                
            case "D":
                return [0: [2, 5], 1: [3, 5], 2: [2, 4], 3: [2, 4], 4: [2, 5], 5: [2, 5]]
                
            case "C":
                return [0: [0, 3], 1: [1, 3], 2: [0, 2], 3: [0, 2], 4: [3], 5: [0, 3]]

            case "E":
                return [0: [9, 12], 1: [9, 12], 2: [9, 11], 3: [9, 11], 4: [9, 11], 5: [9, 12]]
                
            case "A":
                return [0: [2, 5], 1: [2, 5], 2: [2, 4], 3: [2, 4], 4: [2, 4], 5: [2, 5]]
                
            default:
                return [:]
            }
        }
        return [:]
    }
}
