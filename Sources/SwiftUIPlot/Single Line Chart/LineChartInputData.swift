//
//  LineChartInputData.swift
//  
//
//  Created by Andreas Gejl on 04/04/2020.
//

import Foundation
import CoreGraphics
import SwiftUI

@available (iOS 13.0, *)
public struct LineChartInputData: Identifiable {
    public let id: UUID = UUID()
    let xvalues: [Double]
    let yvalues: [Double]
    let plotType: PlotType
    let curveType: CurveType
    let color: Color
    
    public init(xvalues: [Double] = [], yvalues: [Double], plotType: PlotType = .stroke(), curveType: CurveType = .cubicBezier, color: Color = .black) {
        self.xvalues = xvalues.count == yvalues.count ? xvalues : yvalues.enumerated().map { Double($0.offset) }
        self.yvalues = yvalues
        self.plotType = plotType
        self.curveType = curveType
        self.color = color
    }
    
    public enum PlotType {
        case stroke(width: CGFloat = 2.0, dashFreq: CGFloat = 1.0)
        case fill
    }

    public enum CurveType {
        case segmentedLines
        case cubicBezier
    }
}

