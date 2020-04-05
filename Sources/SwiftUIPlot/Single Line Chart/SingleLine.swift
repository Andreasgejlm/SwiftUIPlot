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
    let data: LineChartInputData
    let xlim: [Double]
    let ylim: [Double]
    let proxy: GeometryProxy
    
    var body: some View {
        switch data.plotType {
        case .stroke(let width, let dashFreq):
            return AnyView(CubicBezier(xvalues: data.xvalues,
                                       yvalues: data.yvalues,
                                       xlim: xlim,
                                       ylim: ylim,
                                       type: data.curveType,
                                       in: proxy.frame(in: .global))
                                .stroke(style: StrokeStyle(lineWidth: width,
                                                           lineCap: .round,
                                                           dash: [dashFreq])))
        case .fill:
            return AnyView(CubicBezier(xvalues: data.xvalues,
                                       yvalues: data.yvalues,
                                       xlim: xlim,
                                       ylim: ylim,
                                       type: data.curveType,
                                       in: proxy.frame(in: .global),
                                       closed: true))
        }
    }
}
