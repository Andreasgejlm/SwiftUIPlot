//
//  SwiftUILineChart.swift
//  SwiftUILineChart
//
//  Created by Andreas Gejl on 30/03/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LineChart: View {
    let model: LineChartModel
    var design: LineChartCustomization
    @State var show = false
    
    public init(data: [LineChartInputData], xlabels: [String]? = nil) {
        self.model = LineChartModel(data: data, xlabels: xlabels)
        self.design = LineChartCustomization()
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: design.backgroundStyling.cornerRadius)
                .fill(design.backgroundStyling.color)
            GeometryReader { proxy in
                VStack {
                    VStack(spacing: 0) {
                        HStack(alignment: .top, spacing: 0) {
                            yAxis(ylim: self.model.ylim, design: self.design.yAxisDesign)
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
                                    ForEach(self.model.data) { inputData in
                                        SingleLine(xvalues: inputData.xvalues,
                                                   yvalues: inputData.yvalues,
                                                   ylim: self.model.ylim,
                                                   proxy: reader,
                                                   type: inputData.plotType)
                                            .foregroundColor(inputData.color)
                                    }
                                }
                            }
                            .frame(width: proxy.size.width - self.design.yAxisDesign.dimension,
                                   height: proxy.size.height - self.design.xAxisDesign.dimension)
                        }
                        HStack {
                            Spacer()
                            xAxis(labels: self.model.xlabels,
                                  xlim: self.model.xlim, design: self.design.xAxisDesign)
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
extension LineChart {
    
    public func backgroundStyle(color: Color = .clear, cornerRadius: CGFloat = 0.0) -> Self {
        let copy = self
        copy.design.backgroundStyling.color = color
        copy.design.backgroundStyling.cornerRadius = cornerRadius
        return copy
    }
    
    public func horizontalAxisStyle(showText: Bool = true, font: Font = .caption, textColor: Color = .gray, height: CGFloat = 50) -> Self {
        let copy = self
        copy.design.xAxisDesign.showAxisText = showText
        copy.design.xAxisDesign.axisFont = font
        copy.design.xAxisDesign.axisTextColor = textColor
        copy.design.xAxisDesign.dimension = height
        return copy
    }
    
    public func verticalAxisStyle(showText: Bool = true, font: Font = .caption, textColor: Color = .gray, width: CGFloat = 50) -> Self {
        let copy = self
        copy.design.yAxisDesign.showAxisText = showText
        copy.design.yAxisDesign.axisFont = font
        copy.design.yAxisDesign.axisTextColor = textColor
        copy.design.yAxisDesign.dimension = width
        return copy
    }
    
    public func horizontalGridStyle(gridLineColor: Color = .gray, gridLineWidth: CGFloat = 0.5, gridLineDashFrequency: CGFloat = 5) -> Self {
        let copy = self
        copy.design.horizontalGridLineDesign.showLines = true
        copy.design.horizontalGridLineDesign.lineColor = gridLineColor
        copy.design.horizontalGridLineDesign.lineWidth = gridLineWidth
        copy.design.horizontalGridLineDesign.dashFreq = gridLineDashFrequency
        return copy
    }
    
    public func verticalGridStyle(gridLineColor: Color = .gray, gridLineWidth: CGFloat = 0.5, gridLineDashFrequency: CGFloat = 5) -> Self {
        let copy = self
        copy.design.verticalGridLineDesign.showLines = true
        copy.design.verticalGridLineDesign.lineColor = gridLineColor
        copy.design.verticalGridLineDesign.lineWidth = gridLineWidth
        copy.design.verticalGridLineDesign.dashFreq = gridLineDashFrequency
        return copy
    }
}

