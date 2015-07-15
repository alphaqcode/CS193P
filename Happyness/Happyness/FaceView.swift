//
//  FaceView.swift
//  Happyness
//
//  Created by 杜晓辉 on 15/7/14.
//  Copyright (c) 2015年 杜晓辉. All rights reserved.
//

import UIKit

@IBDesignable

class FaceView: UIView {
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay()}}
    
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay()}}
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay()}}
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    var faceRadius : CGFloat {
            return min(bounds.size.width,bounds.size.height)/2 * scale
    }
    
    private struct Scaling{
        static let faceRadiusToEyeRadiusRatio: CGFloat = 10
        static let faceRadiusToEyeOffsetRatio: CGFloat = 3
        static let faceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let faceRadiusToMouthWidthRatio: CGFloat = 1
        static let faceRadiusToMouthHeightRatio: CGFloat = 3
        static let faceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye {
        case left,right
    }
    
    private func bezierPathForEye(whichEye:Eye) -> UIBezierPath{
        var eyeRadius = faceRadius / Scaling.faceRadiusToEyeRadiusRatio
        var eyeHorizontalSeparation = faceRadius / Scaling.faceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= faceRadius / Scaling.faceRadiusToEyeOffsetRatio
        
        switch whichEye {
        case .left: eyeCenter.x -= eyeHorizontalSeparation/2
        case .right: eyeCenter.x += eyeHorizontalSeparation/2
        }
        
        let eyePath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        eyePath.lineWidth = lineWidth
        return eyePath
        
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile:Double) -> UIBezierPath{
        let mouthWidth = faceRadius / Scaling.faceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.faceRadiusToMouthHeightRatio
        let mouthOffset = faceRadius / Scaling.faceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth/2, y: faceCenter.y + mouthOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        
        let cp1 = CGPoint(x: start.x + mouthWidth/3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth/3, y: cp1.y)
        
        let mouthPath = UIBezierPath()
        mouthPath.moveToPoint(start)
        mouthPath.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        
        mouthPath.lineWidth = lineWidth
        return mouthPath
        
    }
    
    override func drawRect(rect: CGRect) {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        facePath.lineWidth = lineWidth
        color.set()
        
        facePath.stroke()
        bezierPathForEye(.left).stroke()
        bezierPathForEye(.right).stroke()
        
        bezierPathForSmile(-0.7).stroke()
        
    }
    
    

}
