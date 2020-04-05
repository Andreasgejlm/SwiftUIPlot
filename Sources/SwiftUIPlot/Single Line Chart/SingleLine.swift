//
//  SingleLine.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 02/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct SingleLine: View {
    let xvalues: [Double]
    let yvalues: [Double]
    let xlim: [Double]
    let ylim: [Double]
    let proxy: GeometryProxy
    let type: LineChartInputData.PlotType
    
    init(xvalues: [Double], yvalues: [Double], xlim: [Double], ylim: [Double], proxy: GeometryProxy, type: LineChartInputData.PlotType) {
        self.xvalues = xvalues
        self.yvalues = yvalues
        self.xlim = xlim
        self.ylim = ylim
        self.proxy = proxy
        self.type = type
    }
    
    var body: some View {
        switch type {
        case .stroke(let width, let dashFreq):
            return AnyView(CubicBezier(xvalues: xvalues,
                                       yvalues: yvalues,
                                       xlim: xlim,
                                       ylim: ylim,
                                       in: proxy.frame(in: .global))
                                .stroke(style: StrokeStyle(lineWidth: width,
                                                           lineCap: .round,
                                                           dash: [dashFreq])))
        case .fill:
            return AnyView(CubicBezier(xvalues: xvalues,
                                       yvalues: yvalues,
                                       xlim: xlim,
                                       ylim: ylim,
                                       in: proxy.frame(in: .global),
                                       closed: true))
        }
    }
}
