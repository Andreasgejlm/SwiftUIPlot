//
//  CombinedLine.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 02/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct BackgroundLineStack: View {
    let xvalues: [Double]
    let backgroundValues: [Double]
    let foregroundValues: [Double]
    let ylim: [Double]
    let proxy: GeometryProxy
    let backgrounddesign: LineChartCustomization.LineCustomization
    let foregrounddesign: LineChartCustomization.LineCustomization
    @State var trimming: Bool = false
    
    var body: some View {
        ZStack {
            CubicBezier(xvalues: xvalues,
                        yvalues: backgroundValues,
                        in: proxy.frame(in: .global),
                        closed: true)
                .fill(backgrounddesign.shadedColor)
            CubicBezier(xvalues: xvalues,
                        yvalues: foregroundValues,
                        ylim: ylim,
                        in: proxy.frame(in: .global))
                .trim(from: 0, to: trimming ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: foregrounddesign.lineWidth,
                                           lineCap: .round,
                                           dash: [foregrounddesign.dashFreq]))
                .foregroundColor(foregrounddesign.lineColor)
                .onAppear {
                    withAnimation(self.foregrounddesign.animation) {
                        self.trimming = true
                    }
            }
        }
    }
}
