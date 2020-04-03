//
//  BackgroundLineChartModel.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 03/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
class BackgroundLineChartModel {
    let xvals: [Double]
    let backgroundyvals: [Double]
    let foregroundyvals: [Double]
    let xlabels: [String]?
    let xlim: [Double]
    let ylim: [Double]
    
    init(xs: [Double], backgroundyvals: [Double], foregroundyvals: [Double], xlabels: [String]?, xlim: [Double], ylim: [Double]) {
        xvals = xs
        self.backgroundyvals = backgroundyvals
        self.foregroundyvals = foregroundyvals
        self.xlabels = xlabels
        self.xlim = xlim
        self.ylim = ylim
    }
    
}
@available(iOS 13.0, *)
class BackgroundLineChartCustomization: LineChartCustomization {
    
    var backgroundlineDesign: LineCustomization = LineCustomization(shaded: true,
                                                                    shadedColor: .gray)
    var foregroundlineDesign: LineCustomization = LineCustomization(shaded: false)

}
