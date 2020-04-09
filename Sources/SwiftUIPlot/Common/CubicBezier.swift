//
//  SwiftUICubicBezier.swift
//  SwiftUICubicBezier
//
//  Created by Andreas Gejl on 29/03/2020.
//  Copyright © 2020 Andreas Gejl Madsen. All rights reserved.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct CubicBezier: Shape {
    var points: [CGPoint]
    let type: LineChartInputData.CurveType
    private let closed: Bool
    
    init(xvalues: [Double], yvalues: [Double], xlim: [Double], ylim: [Double] = [], type: LineChartInputData.CurveType = .cubicBezier, in rect: CGRect, controlPointLength: CGFloat = 0.5, closed: Bool = false) {
        let height: CGFloat = rect.height
        let width: CGFloat = rect.width
        let maxx: Double = xlim.count > 0 ? xlim[1] : xvalues.max() ?? 1
        let minx: Double = xlim.count > 0 ? xlim[0] : xvalues.min() ?? 0
        let spanx: CGFloat = CGFloat(maxx - minx)
        let pxPerx: CGFloat = width / spanx
        
        let maxy: Double = ylim.count > 0 ? ylim[1] : yvalues.max() ?? 1
        let miny: Double = ylim.count > 0 ? ylim[0] : yvalues.min() ?? 0
        let spany: CGFloat = CGFloat(maxy - miny)
        let pxPery: CGFloat = height / spany
        
        let yPositions: [CGFloat] = yvalues.map{ height - CGFloat($0 - miny) * pxPery}
        let xPositions: [CGFloat] = xvalues.map{ CGFloat($0 - minx) * pxPerx}
                
        points = yPositions.enumerated().map { CGPoint(x: xPositions[$0.offset], y: $0.element) }
        
        self.closed = closed
        self.type = type
        if closed {
            points.append(CGPoint(x: xPositions.last ?? 0, y: height))
            points.append(CGPoint(x: 0, y: height))
        }
    }

    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        if points.count < 2 {
            return path
        }
        var p1: CGPoint = .zero
        var p2: CGPoint = .zero
        var p3: CGPoint = .zero
        var cp1: CGPoint = .zero
        var cp2: CGPoint = .zero
        p1 = points[0]
        p2 = points[1]
        path.move(to: p1)
        if points.count == 2{
            path.addLine(to: p2)
            return path
        } else if points.count <= 4 && closed {
            path.addLines(points)
            return path
        }
        
        let closedOffset: Int = closed ? 2 : 0
        
        switch type {
        case .segmentedLines:
            path.addLines(points)
            return path
        default:
            for i in 2..<points.count - closedOffset {
                p1 = points[i - 2]
                p2 = points[i - 1]
                p3 = points[i]
                
                if i == 2 {
                    let mid = midpoint(between: (p1, p2))
                    cp1 = oneEndedControlPoint(points: (p1, mid))
                } else {
                    cp1 = controlPoint(from: p1, prevCP: cp2)
                }
                
                var bilinear: CGPoint = p3 - p1
                var h: CGFloat = p2.x - p1.x
                h = h < 100 ? h : p3.x - p2.x
                cp2 = p2 - (bilinear.norm() * h / 2.0)
                
                path.addCurve(to: p2, control1: cp1, control2: cp2)
            }
            if closed {
                cp2 = controlPoint(from: p2, prevCP: cp2)
                cp1 = oneEndedControlPoint(points: (p3, p2))
                path.addCurve(to: p3, control1: cp2, control2: cp1)
                path.addLine(to: points[points.count - 2])
                path.addLine(to: points.last ?? .zero)
            } else {
                cp2 = controlPoint(from: p2, prevCP: cp2)
                cp1 = oneEndedControlPoint(points: (p3, p2))
                path.addCurve(to: p3, control1: cp2, control2: cp1)
            }
            
            return path
        }
    }
    
    private func midpoint(between: (CGPoint, CGPoint)) -> CGPoint {
        let midx: CGFloat = (between.1.x + between.0.x) / 2.0
        let midy: CGFloat = (between.1.y + between.0.y) / 2.0
        return CGPoint(x: midx, y: midy)
    }
    
    private func oneEndedControlPoint(points: (CGPoint, CGPoint)) -> CGPoint {
        return midpoint(between: points)
    }
    
    private func controlPoint(from: CGPoint, prevCP: CGPoint) -> CGPoint {
        return from * 2.0 - prevCP
    }
    
    
}


extension CGPoint {
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    static func /(lhs: CGPoint, rhs: Double) -> CGPoint {
        return CGPoint(x: lhs.x / CGFloat(rhs), y: lhs.y / CGFloat(rhs))
    }
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    static func *(lhs: CGPoint, rhs: Double) -> CGPoint {
        return CGPoint(x: lhs.x * CGFloat(rhs), y: lhs.y * CGFloat(rhs))
    }
    static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    mutating func norm() -> CGPoint {
        return self / self.mag()
    }
    
    mutating func mag() -> CGFloat {
        let xs: CGFloat = pow(self.x, 2)
        let ys: CGFloat = pow(self.y, 2)
        return sqrt(xs + ys)
    }
}
