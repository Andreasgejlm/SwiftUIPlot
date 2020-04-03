//
//  LineChartModel.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 30/03/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
class LineChartModel {
    let xvals: [Double]
    let yvals: [Double]
    let xlabels: [String]?
    let xlim: [Double]
    let ylim: [Double]
    
    init(xs: [Double], ys: [Double], xlabels: [String]?, xlim: [Double], ylim: [Double]) {
        xvals = xs
        yvals = ys
        self.xlabels = xlabels
        self.xlim = xlim
        self.ylim = ylim
    }
    
}

@available(iOS 13.0, *)
class LineChartCustomization {
    var backgroundStyling: BackgroundStyling = BackgroundStyling()
    
    var lineDesign: LineCustomization = LineCustomization()
    
    var xAxisDesign: AxisCustomization = AxisCustomization()
    
    var yAxisDesign: AxisCustomization = AxisCustomization()
    
    var horizontalGridLineDesign: GridLineCustomization = GridLineCustomization()
    
    var verticalGridLineDesign: GridLineCustomization = GridLineCustomization()
    
    struct BackgroundStyling {
        var color: Color = .clear
        var cornerRadius: CGFloat = 0.0
    }
    
    struct LineCustomization {
        var shaded: Bool = false
        var lineColor: Color = .black
        var lineWidth: CGFloat = 2.0
        var dashFreq: CGFloat = 1.0
        var shadedColor: Color = .clear
        var animation: Animation? = nil
    }
    
    struct AxisCustomization {
        var showAxisText: Bool = true
        var axisFont: Font = .caption
        var axisTextColor: Color = .gray
        var dimension: CGFloat = 50
    }
    
    struct GridLineCustomization {
        var showLines: Bool = false
        var lineColor: Color = .gray
        var lineWidth: CGFloat = 1
        var dashFreq: CGFloat = 5
    }
    
}
