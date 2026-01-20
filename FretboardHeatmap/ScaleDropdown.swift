//
//  ScaleDropdown.swift
//  FretboardHeatmap
//
//  Created by Sean Avery Suguitan on 2026-01-17.
//
//  Renders a dropdown for scale options when "SCALES" is selected

import SwiftUI

struct ScaleDropDown: View {
    @Binding var selectedScaleType: String

    let scales = ["Maj Pentatonic", "Min Pentatonic"]
    
    var body: some View {
        Menu {
            ForEach(scales, id: \.self) { scale in
                Button(scale) {
                    withAnimation(.easeIn(duration: 0.2)) {
                        selectedScaleType = scale
                    }
                }
            }
        } label: {
            HStack(spacing: 5) {
                Text(selectedScaleType.uppercased())
                    .font(.system(size: 17, weight: .bold))
                Image(systemName: "chevron.down")
                    .font(.headline)
            }
            .foregroundColor(.yellow)
        }
    }
}
