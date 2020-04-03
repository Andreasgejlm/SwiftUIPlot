//
//  SingleLine.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 02/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SingleLineStack: View {
    let xvalues: [Double]
    let yvalues: [Double]
    let proxy: GeometryProxy
    let design: LineChartCustomization.LineCustomization
    @State var trimming: Bool = false
    
    var body: some View {
        ZStack {
            if design.shaded {
                CubicBezier(xvalues: xvalues,
                            yvalues: yvalues,
                            in: proxy.frame(in: .global),
                            closed: true)
                    .fill(design.shadedColor)
            }
            CubicBezier(xvalues: xvalues,
                        yvalues: yvalues,
                        in: proxy.frame(in: .global))
                .trim(from: 0, to: trimming ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: design.lineWidth,
                                           lineCap: .round,
                                           dash: [design.dashFreq]))
                .foregroundColor(design.lineColor)
                .onAppear {
                    withAnimation(self.design.animation) {
                        self.trimming = true
                    }
            }
        }
    }
}
