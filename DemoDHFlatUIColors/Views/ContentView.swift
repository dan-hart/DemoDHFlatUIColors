//
//  ContentView.swift
//  DemoDHFlatUIColors
//
//  Created by Dan Hart on 11/11/24.
//

import SwiftUI
import DHFlatUIColors

struct ContentView: View {
    @State private var searchText = ""
    @ScaledMetric private var size: CGFloat = 30
    
    var filteredPalettes: [DHFlatUIColors.Palette] {
        if searchText.isEmpty {
            return DHFlatUIColors.Palette.allCases
        } else {
            return DHFlatUIColors.Palette.allCases.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredPalettes, id: \.self) { palette in
                    NavigationLink(destination: PaletteView(palette: palette)) {
                        VStack(alignment: .leading) {
                            ColorGridView(palette: palette, allowCopy: true)
                            Text(palette.name)
                                .font(.title)
                        }
                        .padding()
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("DemoDHFlatUIColors")
        }
    }
}

#Preview {
    ContentView()
}
