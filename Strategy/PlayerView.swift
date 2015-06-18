//
//  PlayerView.swift
//  Strategy
//
//  Created by Jessica Oliveira on 12/06/15.
//  Copyright (c) 2015 Paula Marinho Zago. All rights reserved.
//

import UIKit

class PlayerView: UIView {
    
    var color: UIColor = UIColor.blackColor()
    var text: String = ""
    var label: UILabel = UILabel()
    var mainView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    init(color: UIColor, text: Int, constX: CGFloat, constY: CGFloat, view: UIView, mainView: UIView){
        self.color = color
        self.text = String(text)
        self.mainView = mainView
        
        super.init(frame: CGRectMake(view.frame.width*constX, view.frame.height*constY, view.frame.width*0.05, view.frame.width*0.05))
        
        self.setColor(self, color: color)
        
        self.createFormatView(self, mainView: mainView)
        
        self.label = self.createLabel(text, view: view)
        self.addSubview(label)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createLabel(index: Int, view: UIView) -> UILabel{
        var label = UILabel(frame: CGRectMake(0, 0, 30, 20))
        label.center = CGPointMake(view.frame.width*0.025, view.frame.width*0.025)
        label.textAlignment = NSTextAlignment.Center
        label.text = String(index)
        label.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        label.font = UIFont.boldSystemFontOfSize(20)
        
        return label
    }
    
    func createFormatView(DynamicView: UIView, mainView: UIView){
        DynamicView.layer.cornerRadius = 25.0
        DynamicView.layer.borderWidth = 4
        DynamicView.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0).CGColor
        
        var panPlayer = UIPanGestureRecognizer(target:self, action:"pan:")
        DynamicView.addGestureRecognizer(panPlayer)
        
        self.mainView.addSubview(DynamicView)
    }

    func setColor(view: UIView, color : UIColor){
        view.backgroundColor = color
    }
    
    func pan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.mainView)
        recognizer.view!.transform = CGAffineTransformTranslate(recognizer.view!.transform, translation.x, translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.mainView)
    }
    
    func getLabel() -> String{
        return self.label.text!
    }
    
    func getColor() -> UIColor{
        return self.color
    }
    
    func setLabelChange(labelNew: String){
        self.label.text = labelNew
        self.text = labelNew
    }

    
    func setBackGroungColor(color: UIColor){
        self.backgroundColor = color
        self.color = color
    }
    
    func removeItself(){
        self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        var textStore: String = self.text
        setLabelChange("")
        self.text = textStore
        self.layer.borderWidth=0

    }
    
    func appearItself(){
        self.layer.borderWidth=2

        self.backgroundColor = self.color
        setLabelChange(self.text)
    }
    
    func changeSuperView(view: UIView){
        self.mainView = view
        self.mainView.addSubview(self)
    }

}


