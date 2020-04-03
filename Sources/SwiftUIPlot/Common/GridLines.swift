//
//  GridLines.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 01/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct HorizontalGridLines: View {
    let ylim: [Double]
    let design: LineChartCustomization.GridLineCustomization
    private let snappedValues: [Int]
    let N: Int = 6
    let span: Double
    
    init(ylim: [Double], design: LineChartCustomization.GridLineCustomization) {
        self.ylim = ylim
        let span = ylim[1] - ylim[0]
        self.span = span
        var roundTo: Int = 0
        switch span {
        case 0.0...50:
            roundTo = 1
        case 51...500:
            roundTo = 10
        case 501...5000:
            roundTo = 100
        case 5001...50000:
            roundTo = 1000
        case 50001...500000:
            roundTo = 10000
        default:
            roundTo = 1
        }
        let values = linspace(lim: ylim, N: N)
        snappedValues = values.map { roundTo * Int(round($0/Double(roundTo))) }
        self.design = design
    }
    
    func calculateHeight(index: Int, height: CGFloat) -> CGFloat {
        let value: Double = Double(snappedValues[index])
        let pxPerVal: CGFloat = height / CGFloat(span)
        let newHeight: CGFloat = height - CGFloat(value - ylim[0]) * pxPerVal
        return newHeight
    }
    
    func horizontalLine(width: CGFloat) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: width, y: 0))
        return p
    }

    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                ForEach((0..<self.N), id: \.self) {i in
                    ZStack {
                        self.horizontalLine(width: reader.size.width)
                            .stroke(style: StrokeStyle(lineWidth: self.design.lineWidth, lineCap: .round, dash: [self.design.dashFreq]))
                            .foregroundColor(self.design.lineColor)
                            .offset(x: 0.0, y: self.calculateHeight(index: i, height: reader.size.height))
                    }
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct VerticalGridLines: View {
    let N: Int
    let design: LineChartCustomization.GridLineCustomization
    
    init(labels: [String]? = nil, design: LineChartCustomization.GridLineCustomization) {
        if let _labels = labels {
            N = _labels.count
        } else {
            N = 5
        }
        self.design = design
    }
    
    func calculatePosition(index: Int, width: CGFloat) -> CGFloat {
        return CGFloat(index) * width / CGFloat(self.N - 1)
    }
    
    func verticalLine(height: CGFloat) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: 0, y: height))
        return p
    }
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                ForEach((0..<self.N), id: \.self) { i in
                    ZStack {
                        self.verticalLine(height: reader.size.height)
                            .stroke(style: StrokeStyle(lineWidth: self.design.lineWidth, lineCap: .round, dash: [self.design.dashFreq]))
                            .foregroundColor(self.design.lineColor)
                            .offset(x: self.calculatePosition(index: i, width: reader.size.width), y: 0.0)
                    }
                }
            }
        }
    }
}
