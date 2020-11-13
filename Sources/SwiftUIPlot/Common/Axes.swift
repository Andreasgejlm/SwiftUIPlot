//
//  Axes.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 30/03/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct xAxis: View {
    let xlim: [Double]
    private let _labels: [String]
    let N: Int
    let tickWidth: CGFloat = 40
    let design: LineChartCustomization.AxisCustomization
    
    
    init(labels: [String]? = nil, xlim: [Double], design: LineChartCustomization.AxisCustomization) {
        self.xlim = xlim
        if let _labels = labels {
            self._labels = _labels
            N = _labels.count
        } else {
            N = 5
            self._labels = linspace(lim: xlim, N: N).map {String($0)}
        }
        self.design = design
    }

    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                ForEach((0..<self.N), id: \.self) { i in
                    ZStack {
                        if (self.design.showAxisText) {
                            Text(self._labels[i])
                                .font(self.design.axisFont)
                                .foregroundColor(self.design.axisTextColor)
                                .frame(width: self.tickWidth)
                                .offset(x: CGFloat(i) * (reader.size.width) / CGFloat((self.N - 1)) - reader.size.width/2.0,
                                    y: 0.0)
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 13.0, *)
struct yAxis: View {
    let ylim: [Double]
    private let snappedValues: [Int]
    let N: Int = 6
    let span: Double
    let design: LineChartCustomization.AxisCustomization
    
    init(ylim: [Double], design: LineChartCustomization.AxisCustomization) {
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
        let newHeight: CGFloat = height - CGFloat(value - ylim[0]) * pxPerVal - height / 2
        return newHeight
    }

    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .leading) {
                ForEach((0..<self.snappedValues.count), id: \.self) {i in
                    ZStack {
                        if self.design.showAxisText {
                            Text(String(self.snappedValues[i]))
                                .font(self.design.axisFont)
                                .foregroundColor(self.design.axisTextColor)
                                .frame(width: reader.size.width, height: 15)
                                .offset(x: 0.0, y: self.calculateHeight(index: i, height: reader.size.height))
                        }
                    }
                }
            }
        }
    }
}


func linspace(lim: [Double], N: Int) -> [Double] {
    var arr: [Double] = []
    let min = lim.min() ?? 0
    let max = lim.max() ?? 1
    if min == max {
        return [min]
    }
    let h = (max - min) / Double(N - 1)
    for i in stride(from: min, to: max + h, by: h) {
        arr.append(i)
    }
    return arr
}
