//
//  PaletteView.swift
//  DemoDHFlatUIColors
//
//  Created by Dan Hart on 11/11/24.
//

import SwiftUI
import DHFlatUIColors
import AlertToast

struct PaletteView: View {
    @State var searchText = ""
    let palette: DHFlatUIColors.Palette
    @ScaledMetric private var size: CGFloat = 100
    
    @State private var showToast = false
    @State private var toastColor: Color?
    @State private var toastMessage: String?
    
    var filteredColors: [ColorInfo] {
        if searchText.isEmpty {
            return palette.colors
        } else {
            return palette.colors.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
            List {
                VStack(alignment: .leading) {
                    ColorGridView(palette: palette, allowCopy: true)
                        .padding()
                }
                ForEach(filteredColors, id: \.name) { color in
                    HStack {
                        Rectangle()
                            .frame(width: size, height: size)
                            .foregroundStyle(color.color)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(color.name)
                                .font(.headline)
                            Text(color.hex)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button {
#if canImport(UIKit)
                            UIPasteboard.general.string = color.hex
#elseif canImport(AppKit)
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(color.hex, forType: .string)
#endif
                            showToast = true
                            toastColor = color.color
                            toastMessage = "Copied \(color.name)'s hex value to clipboard."
                        } label: {
                            Label {
                                Text("Copy Hex")
                            } icon: {
                                Image(systemName: "doc.on.doc")
                            }
                            .foregroundStyle(.primary)
#if os(iOS)
                            .labelStyle(.iconOnly)
#endif
                            .imageScale(.large)
                        }
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle(palette.name)
            .toast(isPresenting: $showToast, duration: 2) {
                AlertToast(displayMode: .alert, type: .complete(toastColor ?? Color.green), title: "Success", subTitle: toastMessage ?? "")
            }
    }
}

#Preview {
    NavigationStack {
        PaletteView(palette: .flatUiV1)
    }
}

