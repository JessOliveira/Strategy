//
//  DrawView.swift
//  Strategy
//
//  Created by Paula Marinho Zago on 6/12/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var drawColor = UIColor.blackColor()
    var paint = true
    var begin: [Int] = []

    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.begin.append(self.lines.count)
        if(self.paint == true){
            if let var touch = touches.first as? UITouch {
                lastPoint = touch.locationInView(self)
            }
            super.touchesBegan(touches , withEvent:event)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if(self.paint == true){

            if let var touch = touches.first as? UITouch {
                var newPoint = touch.locationInView(self)
                lines.append(Line(start: lastPoint, end: newPoint, color: drawColor))
                lastPoint = newPoint
            }
            super.touchesBegan(touches , withEvent:event)
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect (rect: CGRect){
        if(self.paint == true){

            var context  = UIGraphicsGetCurrentContext()
            CGContextSetLineCap(context, kCGLineCapRound)
            CGContextSetLineWidth(context, 8)
            for line in lines{
                CGContextBeginPath(context)
                CGContextMoveToPoint(context, line.startX, line.startY)
                CGContextAddLineToPoint(context, line.endX, line.endY)
                CGContextSetStrokeColorWithColor(context, line.color.CGColor)
                CGContextStrokePath(context)
            }
        }
    }
    
    func setterPaint(type: Bool){
        self.paint = type
    }
    
    func getPaint() -> Bool{
        return self.paint
    }
    
}