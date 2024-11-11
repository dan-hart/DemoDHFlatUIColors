//
//  ColorGridView.swift
//  DemoDHFlatUIColors
//
//  Created by Dan Hart on 11/11/24.
//

import SwiftUI
import DHFlatUIColors
import AlertToast

struct ColorGridView: View {
    let palette: DHFlatUIColors.Palette
    let allowCopy: Bool
    @ScaledMetric private var size: CGFloat = 50
    @State private var showToast = false
    @State private var toastColor: Color?
    @State private var toastMessage: String?
    
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: size)), count: 5), spacing: 10) {
                ForEach(palette.colors, id: \.name) { color in
                    VStack {
                        Rectangle()
                            .frame(width: size, height: size)
                            .foregroundStyle(color.color)
                            .cornerRadius(10)
                    }
                    .onTapGesture {
                        if allowCopy {
#if canImport(UIKit)
                            UIPasteboard.general.string = color.hex
#elseif canImport(AppKit)
                            NSPasteboard.general.clearContents()
                            NSPasteboard.general.setString(color.hex, forType: .string)
#endif
                            showToast = true
                            toastColor = color.color
                            toastMessage = "Copied \(color.name)'s hex value to clipboard."
                        }
                    }
                }
            }
            if allowCopy {
                Text("Tap a color to copy its hex value.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.vertical)
                    .padding(.horizontal, 0)
            }
        }
        .toast(isPresenting: $showToast, duration: 2) {
            AlertToast(displayMode: .alert, type: .complete(toastColor ?? Color.green), title: "Success", subTitle: toastMessage ?? "")
            
        }
    }
}

#Preview {
    ColorGridView(palette: .flatUiV1, allowCopy: true)
}
