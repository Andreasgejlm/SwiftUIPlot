//
//  File.swift
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
    let plotType: PlotType = .stroke()
    let curveType: CurveType = .cubicBezier
    let color: Color = .black
    
    public enum PlotType {
        case stroke(width: CGFloat = 1.0, dashFreq: CGFloat = 2.0)
        case fill
    }

    public enum CurveType {
        case segmentedLines
        case cubicBezier
    }
}

