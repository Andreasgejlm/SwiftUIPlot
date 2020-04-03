//
//  BackgroundLineChart.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 03/04/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BackgroundLineChart: View {
    let model: BackgroundLineChartModel
    var design: BackgroundLineChartCustomization
    @State var show = false
    
    public init(xvals: [Double] = [], backgroundyvals: [Double], foregroundyvals: [Double], xlabels: [String]? = nil) {
        let backys = backgroundyvals
        let foreys = foregroundyvals
        let xs: [Double] = xvals.count > 0 ? xvals : backys.enumerated().map { Double($0.offset) }
        let xl: [Double] = [xs.min() ?? 0,
                            xs.max() ?? 1]
        let yl: [Double] = [min(backys.min() ?? 0, foreys.min() ?? 0),
                            max(backys.max() ?? 1, foreys.max() ?? 1)]
        self.model = BackgroundLineChartModel(xs: xs,
                                              backgroundyvals: backys,
                                              foregroundyvals: foreys,
                                              xlabels: xlabels,
                                              xlim: xl,
                                              ylim: yl)
        self.design = BackgroundLineChartCustomization()
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: design.backgroundStyling.cornerRadius)
                .fill(design.backgroundStyling.color)
            GeometryReader { proxy in
                VStack {
                    VStack(spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            yAxis(ylim: self.model.ylim,
                                  design: self.design.yAxisDesign)
                                .frame(width: self.design.yAxisDesign.dimension,
                                       height: proxy.size.height - self.design.xAxisDesign.dimension)
                            GeometryReader { reader in
                                ZStack {
                                    if self.design.horizontalGridLineDesign.showLines {
                                        HorizontalGridLines(ylim: self.model.ylim,
                                                            design: self.design.horizontalGridLineDesign)
                                    }
                                    if self.design.verticalGridLineDesign.showLines {
                                        VerticalGridLines(labels: self.model.xlabels,
                                                          design: self.design.verticalGridLineDesign)
                                    }
                                    
                                    BackgroundLineStack(xvalues: self.model.xvals,
                                                        backgroundValues: self.model.backgroundyvals,
                                                        foregroundValues: self.model.foregroundyvals,
                                                        proxy: reader,
                                                        backgrounddesign: self.design.backgroundlineDesign,
                                                        foregrounddesign: self.design.foregroundlineDesign)
                                }
                            }
                            .frame(width: proxy.size.width - self.design.yAxisDesign.dimension,
                                   height: proxy.size.height - self.design.xAxisDesign.dimension)
                        }
                        HStack {
                            Spacer()
                            xAxis(labels: self.model.xlabels,
                                  xlim: self.model.xlim,
                                  design: self.design.xAxisDesign)
                                .frame(width: proxy.size.width - self.design.yAxisDesign.dimension,
                                       height: self.design.xAxisDesign.dimension)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

@available(iOS 13.0, *)
extension BackgroundLineChart {
    
    public func backgroundStyle(color: Color = .clear, cornerRadius: CGFloat = 0.0) -> Self {
        let copy = self
        copy.design.backgroundStyling.color = color
        copy.design.backgroundStyling.cornerRadius = cornerRadius
        return copy
    }
    
    public func backgroundShadowColor(_ shadowColor: Color = .gray) -> Self {
        let copy = self
        copy.design.backgroundlineDesign.shaded = true
        copy.design.backgroundlineDesign.shadedColor = shadowColor
        return copy
    }
    
    public func lineStyle(width: CGFloat = 2, color: Color = .black, dashFrequency: CGFloat = 1.0, animation:Animation? = nil) -> Self {
        let copy = self
        copy.design.foregroundlineDesign.lineWidth = width
        copy.design.foregroundlineDesign.lineColor = color
        copy.design.foregroundlineDesign.dashFreq = dashFrequency
        copy.design.foregroundlineDesign.animation = animation
        return copy
    }
    
    public func horizontalAxisStyle(showText: Bool = true, font: Font = .caption, textColor: Color = .gray, height:CGFloat = 50) -> Self {
        let copy = self
        copy.design.xAxisDesign.showAxisText = showText
        copy.design.xAxisDesign.axisFont = font
        copy.design.xAxisDesign.axisTextColor = textColor
        copy.design.xAxisDesign.dimension = height
        return copy
    }
    
    public func verticalAxisStyle(showText: Bool = true, font: Font = .caption, textColor: Color = .gray, width:CGFloat = 50) -> Self {
        let copy = self
        copy.design.yAxisDesign.showAxisText = showText
        copy.design.yAxisDesign.axisFont = font
        copy.design.yAxisDesign.axisTextColor = textColor
        copy.design.yAxisDesign.dimension = width
        return copy
    }
    
    public func horizontalGridStyle(gridLineColor: Color = .gray, gridLineWidth: CGFloat = 0.5,gridLineDashFrequency: CGFloat = 5) -> Self {
        let copy = self
        copy.design.horizontalGridLineDesign.showLines = true
        copy.design.horizontalGridLineDesign.lineColor = gridLineColor
        copy.design.horizontalGridLineDesign.lineWidth = gridLineWidth
        copy.design.horizontalGridLineDesign.dashFreq = gridLineDashFrequency
        return copy
    }
    
    public func verticalGridStyle(gridLineColor: Color = .gray, gridLineWidth: CGFloat = 0.5,gridLineDashFrequency: CGFloat = 5) -> Self {
        let copy = self
        copy.design.verticalGridLineDesign.showLines = true
        copy.design.verticalGridLineDesign.lineColor = gridLineColor
        copy.design.verticalGridLineDesign.lineWidth = gridLineWidth
        copy.design.verticalGridLineDesign.dashFreq = gridLineDashFrequency
        return copy
    }
}

