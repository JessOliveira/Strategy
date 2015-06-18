//
//  StrategyViewController.swift
//  Strategy
//
//  Created by Jessica Oliveira on 10/06/15.
//  Copyright (c) 2015 Paula Marinho Zago. All rights reserved.
//

import UIKit

class StrategyViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var arrowOpponentImageView: UIImageView!
    @IBOutlet weak var arrowTeamImageView: UIImageView!
    
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var opponentView: UIView!
    
    @IBOutlet weak var teamWidth: NSLayoutConstraint!
    
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var ballImage: UIImageView!
    
    @IBOutlet var drawView : AnyObject?
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    var isPanelExpanded = false;

    var isClear = false;
    
    var willRemove = false;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var pan = UIPanGestureRecognizer(target:self, action:"pan:")
        self.ballView.addGestureRecognizer(pan)
        
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.zoomScale = 0.2
        self.scrollView.clipsToBounds = false
        self.scrollView.contentSize = self.view.frame.size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.arrowTeamImageView.tintColor = UIColor.redColor()
        self.arrowOpponentImageView.tintColor = UIColor.redColor()
        
        //create tap in icon image
        let tapIcon = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
            teamView.addGestureRecognizer(tapIcon)
        
        //create tap in icon image
        let tapIconOpponent = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
        opponentView.addGestureRecognizer(tapIconOpponent)
        
        self.addPlayers()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    }
    
    //MARK: Delegates
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.mainView
    }
    
    //MARK: Tap
    func tapPanel(gesture:UITapGestureRecognizer) {
        
        let animationFunction = isPanelExpanded ? compressPanel : expandPanel
        
        //Animate the panel according to proper state transition
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            animationFunction()
            }, completion: { (result) -> Void in
                //Revert panel state
                self.isPanelExpanded = !self.isPanelExpanded
        })
    }
    
    // MARK: Animation Functions
    func expandPanel() {
        
        //Change button to expand state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        self.teamWidth.constant = self.view.frame.width*0.1

        self.teamWidth.priority = 900
        
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        self.view.layoutIfNeeded()
    }
    
    func compressPanel() {
        //Chnage button to compress state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(0)
        self.teamWidth.priority = 500
        
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(0)

        self.view.layoutIfNeeded()
    }
    
    // MARK: Pan Gesture Functions
    func pan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.mainView!)
        recognizer.view!.transform = CGAffineTransformTranslate(recognizer.view!.transform, translation.x, translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.mainView)
    }
    
    func tapRemove(recognizer: UITapGestureRecognizer){
        if(self.willRemove == true){
            recognizer.view!.removeFromSuperview()
            self.willRemove = false
            self.removeButton.tintColor = UIColor.blackColor()
        }
    }
    
    // MARK: AddPlayers Functions
    func addPlayers(){
        self.isClear = true;
        
        var constX : [CGFloat] = [0.06, 0.11, 0.11, 0.21, 0.21, 0.26, 0.31, 0.31, 0.36, 0.36, 0.41]
        var constY : [CGFloat] = [0.43, 0.23, 0.63, 0.13, 0.73, 0.43, 0.23, 0.63, 0.13, 0.73, 0.43]
        
        for  index in 0...10 {
            var DynamicView=UIView(frame: CGRectMake(self.view.frame.width*constX[index], self.view.frame.height*constY[index], self.view.frame.width*0.05, self.view.frame.width*0.05))
            
            DynamicView.backgroundColor=UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0)
            
            var label = self.createLabel(index + 1)
            DynamicView.addSubview(label)
            
            self.createFormatView(DynamicView)
            
        }
        
        constX = [0.85, 0.80, 0.80, 0.70, 0.70, 0.67, 0.60, 0.60, 0.55, 0.55, 0.50]
        
        for  index in 0...10 {
            //teste de player de novo
            var DynamicView=UIView(frame: CGRectMake(self.view.frame.width*constX[index], self.view.frame.height*constY[index], self.view.frame.width*0.05, self.view.frame.width*0.05))
            
            DynamicView.backgroundColor=UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0)
            
            var label = self.createLabel(index + 1)
            DynamicView.addSubview(label)
            
            self.createFormatView(DynamicView)
            
        }
    }
    
    func createLabel(index: Int) -> UILabel{
        var label = UILabel(frame: CGRectMake(0, 0, 30, 20))
        label.center = CGPointMake(self.view.frame.width*0.025, self.view.frame.width*0.025)
        label.textAlignment = NSTextAlignment.Center
        label.text = String(index)
        label.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1.0)
        label.font = UIFont.boldSystemFontOfSize(20)
        
        return label
    }
    
    func createFormatView(DynamicView: UIView){
        DynamicView.layer.cornerRadius=20
        DynamicView.layer.borderWidth=2
        
        var panPlayer = UIPanGestureRecognizer(target:self, action:"pan:")
        DynamicView.addGestureRecognizer(panPlayer)
        self.mainView!.addSubview(DynamicView)
    }
    
    // MARK: Configurations UIButtonItem
    @IBAction func clearTapped(){
        var theDrawView : DrawView = drawView as! DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
    @IBAction func colorTapped(button: UIBarButtonItem!){
        var theDrawView : DrawView = drawView as! DrawView
        var color : UIColor!
        if(button.tag == 1){
            color = UIColor.redColor()
        }else if (button.tag == 2){
            color = UIColor.blueColor()
        }else if (button.tag == 3){
            color = UIColor.yellowColor()
        }else if (button.tag == 4){
            color = UIColor.blackColor()
        }else if (button.tag == 5){
            color = UIColor.whiteColor()
        }
        theDrawView.drawColor = color
    }
    
    @IBAction func changeMode(button: UIBarButtonItem!){
        if(self.isClear == true){
            for view in self.mainView!.subviews {
                if let tag = view.tag {
                    if tag != 101 {
                        view.removeFromSuperview()
                    }
                }
            }
            self.isClear = false
        }else{
            self.addPlayers()
        }
    }
    
    @IBAction func removePlayer(button: UIBarButtonItem!){
        if(willRemove == false){
            self.willRemove = true
            for view in self.mainView!.subviews {
                if let tag = view.tag {
                    if tag != 101 {
                        button.tintColor = UIColor.grayColor()
                        var tap = UITapGestureRecognizer(target:self, action:"tapRemove:")
                        view.addGestureRecognizer(tap)
                    }
                }
            }
        }else{
            self.willRemove = false
            button.tintColor = UIColor.blackColor()
        }
    }
    
}
