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
    let data: [LineChartInputData]
    let xlabels: [String]?
    let xlim: [Double]
    let ylim: [Double]
    
    init(data: [LineChartInputData], xlabels: [String]?) {
        let xmin: Double = data.map{$0.xvalues.min() ?? 0}.min() ?? 0
        let xmax: Double = data.map{$0.xvalues.max() ?? 1}.max() ?? 1
        let ymin: Double = data.map{$0.yvalues.min() ?? 0}.min() ?? 0
        let ymax: Double = data.map{$0.yvalues.max() ?? 1}.max() ?? 1
        
        self.data = data
        xlim = [xmin, xmax]
        ylim = [ymin, ymax]
        self.xlabels = xlabels
    }
    
}

@available(iOS 13.0, *)
class LineChartCustomization {
    var backgroundStyling: BackgroundStyling = BackgroundStyling()
        
    var xAxisDesign: AxisCustomization = AxisCustomization()
    
    var yAxisDesign: AxisCustomization = AxisCustomization()
    
    var horizontalGridLineDesign: GridLineCustomization = GridLineCustomization()
    
    var verticalGridLineDesign: GridLineCustomization = GridLineCustomization()
    
    struct BackgroundStyling {
        var color: Color = .clear
        var cornerRadius: CGFloat = 0.0
    }
    
    struct AxisCustomization {
        var showAxisText: Bool = true
        var axisFont: Font = .caption
        var axisTextColor: Color = .gray
        var dimension: CGFloat = 30
    }
    
    struct GridLineCustomization {
        var showLines: Bool = false
        var lineColor: Color = .gray
        var lineWidth: CGFloat = 1
        var dashFreq: CGFloat = 5
    }
    
}
