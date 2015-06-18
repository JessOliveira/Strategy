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
    @IBOutlet weak var exchangeButton: UIBarButtonItem!
    
    @IBOutlet weak var benchTeamView: UIView!
    @IBOutlet weak var benchOpponent: UIView!
    
    var isPanelExpanded = false;

    var isClear = false;
    
    var willRemove = false;
    
    var willExchange = false;
    
    var willExchangeTwo = false;

    var playerToMove: PlayerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00))
    
    var colorFromPlayerToMove: UIColor = UIColor()
    
    var bench : [PlayerView] = []
    
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
        
        self.addBeginPlayers()
        var constY: CGFloat = 0.09
        for index in 12...21{
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), text: index, constX: 0.01, constY: constY, view:self.view , mainView: self.benchTeamView)
            DynamicView.removeItself()
            self.bench.append(DynamicView)
            constY += 0.08
        }
        
        constY = 0.09
        for index in 12...21{
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), text: index, constX: 0.04, constY: constY, view:self.view , mainView: self.benchOpponent)
            DynamicView.removeItself()
            self.bench.append(DynamicView)
            constY += 0.08
        }


    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    }
    
    //MARK: Delegates
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.mainView
    }
    
    // MARK: Animation Functions for bench
    func expandPanel() {
        
        //Change button to expand state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        self.teamWidth.constant = self.view.frame.width*0.1

        self.teamWidth.priority = 900
        
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        for view in bench{
            view.appearItself()
        }
        
        self.view.layoutIfNeeded()
    }
    
    func compressPanel() {
        //Chnage button to compress state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(0)
        self.teamWidth.priority = 500
        
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(0)
        for view in bench{
            
            view.removeItself()
        }
        
        self.view.layoutIfNeeded()
    }
    
    // MARK: Pan Gesture Functions
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
    
    func tapExchangeOne(recognizer: UITapGestureRecognizer){
        if(self.willExchange == true){
            var sender: UIView = recognizer.view!
            if(sender.backgroundColor == UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0)){
                
                self.addTapExchange(self.mainView, color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), tagNew: 101)
                
                self.addTapExchange(self.benchOpponent, color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), tagNew: 102)
                
                self.addTapExchange(self.benchTeamView, color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), tagNew: 103)
                
                self.playerToMove = recognizer.view as! PlayerView
                self.colorFromPlayerToMove = self.playerToMove.getColor()
                self.playerToMove.setBackGroungColor(UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 0.5))
                
            }else{
                //not to confuse with the ball
                if(sender.backgroundColor == UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0)){
                    
                    self.addTapExchange(self.mainView, color:UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), tagNew: 101)
                    self.addTapExchange(self.benchTeamView, color:UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), tagNew: 102)
                    self.addTapExchange(self.benchOpponent, color:UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), tagNew: 103)
                    
                    self.playerToMove = recognizer.view as! PlayerView
                    self.colorFromPlayerToMove = self.playerToMove.getColor()
                    self.playerToMove.setBackGroungColor(UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 0.5))
                }
            }

            //disable touch first in the exchange
            self.willExchange = false
            self.willExchangeTwo = true
        }
    }
    
    func tapExchangeTwo(recognizer: UITapGestureRecognizer){
        if(self.willExchangeTwo == true){
            self.willExchangeTwo = false
            self.exchangeButton.tintColor = UIColor.blackColor()
            var playerToMoveToo: PlayerView = recognizer.view as! PlayerView
            
            var str: String = playerToMoveToo.label.text!
            playerToMoveToo.setLabelChange(self.playerToMove.getLabel())
            self.playerToMove.setLabelChange(str)
            self.playerToMove.setBackGroungColor(playerToMoveToo.getColor())
        }
    }

    
    // MARK: AddPlayers Functions
    func addBeginPlayers(){
        var constX : [CGFloat] = [0.06, 0.11, 0.11, 0.21, 0.21, 0.26, 0.31, 0.31, 0.36, 0.36, 0.41]
        var constY : [CGFloat] = [0.43, 0.23, 0.63, 0.13, 0.73, 0.43, 0.23, 0.63, 0.13, 0.73, 0.43]
        
        for  index in 0...10 {
            
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), text: index + 1, constX: constX[index], constY: constY[index], view:self.view , mainView: self.mainView)
        }
        
        constX = [0.85, 0.80, 0.80, 0.70, 0.70, 0.67, 0.60, 0.60, 0.55, 0.55, 0.50]
        
        for  index in 0...10 {
            
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), text: index + 1, constX: constX[index], constY: constY[index], view:self.view , mainView: self.mainView)
        }
    }
    
    func removeAllPlayers(){
        for view in self.mainView!.subviews {
            if let tag = view.tag {
                if tag != 101 {
                    view.removeFromSuperview()
                }
            }
        }
    
    }
    
    func setExchange(viewSuper: UIView, button: UIBarButtonItem, tagNew: Int){
        for view in viewSuper.subviews {
            if let tag = view.tag {
                if tag != tagNew {
                    button.tintColor = UIColor.grayColor()
                    var tap = UITapGestureRecognizer(target:self, action:"tapExchangeOne:")
                    view.addGestureRecognizer(tap)
                }
            }
        }
    }
    
    
    func addTapExchange(viewSuper: UIView, color: UIColor, tagNew: Int){
        for view in viewSuper.subviews {
            if let tag = view.tag {
                if tag != tagNew {
                    if(view.backgroundColor == color){
                        var tap = UITapGestureRecognizer(target:self, action:"tapExchangeTwo:")
                        view.addGestureRecognizer(tap)
                    }
                }
            }
        }
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
            //general - go to state 1
            self.addBeginPlayers()
            self.isClear = false
        }else{
            //empy - go to state 2
            self.removeAllPlayers()
            self.isClear = true
        }
    }
    
    @IBAction func removePlayer(button: UIBarButtonItem!){
        //avoids two selected buttons
        if(self.willExchange == true || self.willExchangeTwo == true){
            
            if(self.willExchangeTwo == true){
                self.playerToMove.setBackGroungColor(self.colorFromPlayerToMove)
            }
            
            self.willExchange = false
            self.willExchangeTwo = false
            self.exchangeButton.tintColor = UIColor.blackColor()
        }
        
        if(self.willRemove == false){
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
    
    @IBAction func exchangePlayer(button: UIBarButtonItem!){
        //avoids two selected buttons
        if(self.willRemove == true || self.willExchangeTwo == true){
            
            if(self.willExchangeTwo == true){
                self.playerToMove.setBackGroungColor(self.colorFromPlayerToMove)
                self.exchangeButton.tintColor = UIColor.blackColor()
                self.willExchange = true
            }
            
            self.willRemove = false
            self.willExchangeTwo = false
            self.removeButton.tintColor = UIColor.blackColor()
        }
        
            if(self.willExchange == false){
                self.willExchange = true
                self.setExchange(self.mainView, button: button, tagNew: 101)
                self.setExchange(self.benchTeamView, button: button, tagNew: 102)
                self.setExchange(self.benchOpponent, button: button, tagNew: 103)
                
            }else{
                self.willExchange = false
                button.tintColor = UIColor.blackColor()
            }
    }
    
    
}
