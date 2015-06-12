//
//  PlayerView.swift
//  Strategy
//
//  Created by Jessica Oliveira on 12/06/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
//    let superView: UIView!
//    let xPosConstraint:  NSLayoutConstraint!
//    let yPosConstraint:  NSLayoutConstraint!
//    var constraints: [NSLayoutConstraint]{  get {
//            return [xPosConstraint, yPosConstraint]
//        }
//    }
//    
//    init(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, color: UIColor, superView: UIView, imageToUse: String? = nil, contentMode: UIViewContentMode = .ScaleAspectFill) {
//        
////        super.init()
//        
//        self.superView = superView
//        
//        self.backgroundColor = color
//        
//        self.setTranslatesAutoresizingMaskIntoConstraints(false)
//        
//        let panGestureRecognizer = UIPanGestureRecognizer()
//        panGestureRecognizer.addTarget(self, action: "draggedView:")
//        self.addGestureRecognizer(panGestureRecognizer)
//        
//        let widthConstraint = NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal,
//            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: width)
//        self.addConstraint(widthConstraint)
//        
//        let heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal,
//            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: height)
//        self.addConstraint(heightConstraint)
//        
//        xPosConstraint = NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal,
//            toItem: superView, attribute: .Leading, multiplier: 1.0, constant: x)
//        
//        yPosConstraint = NSLayoutConstraint(item: self, attribute: .CenterY, relatedBy: .Equal,
//            toItem: superView, attribute: .Top, multiplier: 1.0, constant: y)
//        
//        if imageToUse != nil {
//            if let image = UIImage(named: imageToUse!) {
//                let imageView = UIImageView(image: image)
//                imageView.contentMode = contentMode
//                imageView.clipsToBounds = true
//                imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
//                self.addSubview(imageView)
//                self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1.0, constant: 0))
//                self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0))
//                self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1.0, constant: 0))
//                self.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0))
//            }
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func moveByDeltaX(deltaX: CGFloat, deltaY: CGFloat) {
//        xPosConstraint.constant += deltaX
//        yPosConstraint.constant += deltaY
//    }
//    
//    func draggedView(sender:UIPanGestureRecognizer){
//        if let dragView = sender.view as? PlayerView {
//            superView.bringSubviewToFront(dragView)
//            var translation = sender.translationInView(superView)
//            sender.setTranslation(CGPointZero, inView: superView)
//            dragView.moveByDeltaX(translation.x, deltaY: translation.y)
//        }
//    }
}


