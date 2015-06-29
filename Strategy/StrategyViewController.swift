//
//  StrategyViewController.swift
//  Strategy
//
//  Created by Jessica Oliveira on 10/06/15.
//  Copyright (c) 2015 Paula Marinho Zago. All rights reserved.
//

import UIKit

class StrategyViewController: UIViewController, UIPopoverPresentationControllerDelegate  {
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
    @IBOutlet weak var ChangeButton: UIBarButtonItem!
    
    @IBOutlet weak var benchTeamView: UIView!
    @IBOutlet weak var benchOpponent: UIView!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var addOpponentButton: UIButton!
    @IBOutlet weak var addTeamButton: UIButton!
    @IBOutlet weak var noEditButtonItem: UIBarButtonItem!
    
    var isPanelExpanded = false;
    
    var isClear = false;
    
    var willRemove = false;
    
    var willChange = false;
    
    var willChangeTwo = false;

    var playerToMove: PlayerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00))
    
    var colorFromPlayerToMove: UIColor = UIColor()
    
    var bench : [PlayerView] = []
    
    var soccer : [PlayerView] = []
    
    var blueColor: UIColor = UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0)
    
    var redColor: UIColor = UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //add panGesture in ball
        var pan = UIPanGestureRecognizer(target:self, action:"pan:")
        self.ballView.addGestureRecognizer(pan)
        
        //scrollView
        self.setScroll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //create tap in icon image
        let tapIcon = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
            teamView.addGestureRecognizer(tapIcon)
        
        self.addTeamButton.enabled = false
        self.addOpponentButton.enabled = false
        
        //create tap in icon image
        let tapIconOpponent = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
        opponentView.addGestureRecognizer(tapIconOpponent)
        
        //add players
        self.addBeginPlayers()
        self.addBegingBench()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    }
    
    //MARK: Delegates
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.mainView
    }
    
    // MARK: Animation Functions for bench
    func expandPanel() {
        self.addTeamButton.enabled = true
        self.addOpponentButton.enabled = true
        self.addOpponentButton.imageView?.tintColor = self.redColor
        self.addTeamButton.imageView?.tintColor = self.blueColor
        
        //Change button to expand state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        //bench extand
        self.teamWidth.constant = self.view.frame.width*0.1
        self.teamWidth.priority = 900
        
        //arrow modifies
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        
        //appear the players in bench
        for view in self.bench{
            view.appearItself()
        }
        
        self.view.layoutIfNeeded()
    }
    
    func compressPanel() {
        //Change button to compress state
        self.arrowTeamImageView.transform = CGAffineTransformMakeRotation(0)
        self.teamWidth.priority = 500
        
        self.arrowOpponentImageView.transform = CGAffineTransformMakeRotation(0)
        
        self.addTeamButton.enabled = false
        self.addOpponentButton.enabled = false
        self.addOpponentButton.imageView?.tintColor = UIColor.blackColor()
        self.addTeamButton.imageView?.tintColor = UIColor.blackColor()
        
        var i: Int = 0
        //disappear players in bench
        for view in self.bench{
            if(view.frame.origin.x > 30 && view.frame.origin.x < 940){
                view.changeSuperView(self.mainView)
                
                self.soccer.append(view)
                
                for i in 0...(self.bench.count - 1){
                    if(view == self.bench[i]){
                        self.bench.removeAtIndex(i)
                        break
                    }
                }
                
            }else{
                view.removeItself()
            }
            i++;
        }
        
        self.view.layoutIfNeeded()
    }
    
    func setScroll(){
    //scrollView
    self.scrollView.minimumZoomScale = 1.0
    self.scrollView.maximumZoomScale = 2.0
    self.scrollView.zoomScale = 0.2
    self.scrollView.clipsToBounds = false
    self.scrollView.contentSize = self.view.frame.size
    }
    
    // MARK: Pan Gesture Functions
    
    //tap panel - expand or compress
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
    
    //pan gesture from ball
    func pan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.mainView!)
        recognizer.view!.transform = CGAffineTransformTranslate(recognizer.view!.transform, translation.x, translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.mainView)
    }
    
    //remove one player when the user to select button remove
    func tapRemove(recognizer: UITapGestureRecognizer){
        if(self.willRemove == true){
            for i in 0...(self.soccer.count - 1){
                if(recognizer.view == self.soccer[i]){
                    self.soccer.removeAtIndex(i)
                    break
                }
            }
            recognizer.view!.removeFromSuperview()

            self.willRemove = false
            self.removeButton.tintColor = UIColor.blackColor()
        }
    }
    
    //chage player when the user to select button change - this is first selected
    func tapChangeOne(recognizer: UITapGestureRecognizer){
        if(self.willChange == true){
            var sender: UIView = recognizer.view!
            if(sender.backgroundColor == self.blueColor){
                
                //add gesture change - second pass in the same colors
                self.addTapChange(self.mainView, color: self.blueColor, tagNew: 101)
                self.addTapChange(self.benchOpponent, color: self.blueColor, tagNew: 102)
                self.addTapChange(self.benchTeamView, color: self.blueColor, tagNew: 103)
                
                //change alpha - color selected
                self.playerToMove = recognizer.view as! PlayerView
                self.colorFromPlayerToMove = self.blueColor
                self.playerToMove.setLabelColor()
                
            }else{
                //not to confuse with the ball
                if(sender.backgroundColor == self.redColor){
                    
                    //add gesture change - second pass in the same colors
                    self.addTapChange(self.mainView, color: self.redColor, tagNew: 101)
                    self.addTapChange(self.view, color:self.redColor, tagNew: 102)
                    self.addTapChange(self.benchOpponent, color:self.redColor, tagNew: 103)
                    
                    //change alpha - color selected
                    self.playerToMove = recognizer.view as! PlayerView
                    self.colorFromPlayerToMove = self.redColor
                    self.playerToMove.setLabelColor()
                }
            }

            //disable touch first in the Change
            self.willChange = false
            self.willChangeTwo = true
        }
    }
    
    func tapChangeTwo(recognizer: UITapGestureRecognizer){
        if(self.willChangeTwo == true){
            self.willChangeTwo = false
            //deselect button
            self.ChangeButton.tintColor = UIColor.blackColor()
            
            var playerToMoveToo: PlayerView = recognizer.view as! PlayerView
            
            let center1 = self.playerToMove.center
            let center2 = playerToMoveToo.center
            UIView.animateWithDuration(1.0, animations: {
                playerToMoveToo.center = center1
                self.playerToMove.center = center2
            })
            
            self.playerToMove.backLabelColor()
            
            //change label
            /*
            var str: String = playerToMoveToo.label.text!
            playerToMoveToo.setLabelChange(self.playerToMove.getLabelText())
            self.playerToMove.setLabelChange(str)
            self.playerToMove.backLabelColor()
            
            playerToMoveToo.setLabelColor()
            
            UIView.transitionWithView(playerToMoveToo.label, duration: 3, options: .TransitionCrossDissolve, animations: {
                playerToMoveToo.label.textColor = UIColor.whiteColor()
                }, completion: nil)
            */
//            UILabel.animateWithDuration(1, animations:{ playerToMoveToo.label.textColor = UIColor.blackColor() })
//
//            UILabel.animateWithDuration(1, animations:{ playerToMoveToo.backLabelColor()})
        }
    }
    
    func doubleTap(recognizer:UITapGestureRecognizer) {
        if(self.willChange == false && self.willChangeTwo == false && self.willRemove == false){
            
            var popoverContent = self.storyboard?.instantiateViewControllerWithIdentifier("numberChage") as! PopoverViewController
        
            var nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            nav.navigationBarHidden = false
            nav.navigationBar.barTintColor = UIColor.whiteColor()
        
            var popover = nav.popoverPresentationController
            popoverContent.preferredContentSize = CGSizeMake(200,200)
            popover!.delegate = self
            popover!.permittedArrowDirections = UIPopoverArrowDirection.Any
            popover!.sourceView = recognizer.view
            popover!.sourceRect = CGRectMake(self.view.frame.width*0.05 ,0,0,0)
        
            popoverContent.selectedPlayer = recognizer.view as! PlayerView
            popoverContent.bench = self.bench
            popoverContent.soccer = self.soccer
        
            self.presentViewController(nav, animated: true, completion: nil)
        }
        

    }

    
    // MARK: AddPlayers Functions
    func addBeginPlayers(){
        var constX : [CGFloat] = [0.06, 0.11, 0.11, 0.21, 0.21, 0.26, 0.31, 0.31, 0.36, 0.36, 0.41]
        var constY : [CGFloat] = [0.43, 0.23, 0.63, 0.13, 0.73, 0.43, 0.23, 0.63, 0.13, 0.73, 0.43]
        
        //create player blue in soccer
        for  index in 0...10 {
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 0.1, green: 0.4, blue: 1.0, alpha: 1.0), text: index + 1, constX: constX[index], constY: constY[index], view:self.view , mainView: self.mainView)
            self.soccer.append(DynamicView)
            
            
            var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
            touchDoublePlayer.numberOfTapsRequired  = 2
            DynamicView.addGestureRecognizer(touchDoublePlayer)
        }
        
        constX = [0.85, 0.80, 0.80, 0.70, 0.70, 0.67, 0.60, 0.60, 0.55, 0.55, 0.50]
        
        //create player red in soccer
        for  index in 0...10 {
            var DynamicView: PlayerView = PlayerView(color: UIColor(red: 1.0, green: 0.33, blue: 0.22, alpha: 1.0), text: index + 1, constX: constX[index], constY: constY[index], view:self.view , mainView: self.mainView)
            self.soccer.append(DynamicView)
            
            var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
            touchDoublePlayer.numberOfTapsRequired  = 2
            DynamicView.addGestureRecognizer(touchDoublePlayer)

        }

    }
    
    func addBegingBench(){
        
        var one = 12
            var constantY: CGFloat = 0.19
            //create player blue in bench
            for index in one...one+9{
                var DynamicView: PlayerView = PlayerView(color: self.blueColor, text: index, constX: 0.01, constY: constantY, view:self.view , mainView: self.view)
                DynamicView.removeItself()
                self.bench.append(DynamicView)
                constantY += 0.07
                
                var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
                touchDoublePlayer.numberOfTapsRequired  = 2
                DynamicView.addGestureRecognizer(touchDoublePlayer)
            }
            
            constantY = 0.19
            //create player red in bench
            for index in one...one+9{
                var DynamicView: PlayerView = PlayerView(color: self.redColor, text: index, constX: 0.95, constY: constantY, view:self.view , mainView: self.view)
                DynamicView.removeItself()
                self.bench.append(DynamicView)
                constantY += 0.07
                
                var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
                touchDoublePlayer.numberOfTapsRequired  = 2
                DynamicView.addGestureRecognizer(touchDoublePlayer)
            }
    }
    
    //remove players in soccer
    func removeAllPlayers(){
        for view in self.mainView!.subviews {
            if let tag = view.tag {
                if tag != 101 {
                    view.removeFromSuperview()
                }
            }
        }
    
    }
    
    //add One tap gesture for change player
    func setChange(viewSuper: UIView, button: UIBarButtonItem, tagNew: Int){
        for view in viewSuper.subviews {
            if let tag = view.tag {
                if tag != tagNew {
                    button.tintColor = UIColor.grayColor()
                    var tap = UITapGestureRecognizer(target:self, action:"tapChangeOne:")
                    view.addGestureRecognizer(tap)
                }
            }
        }
    }
    
    //add Two tap gesture for change player
    func addTapChange(viewSuper: UIView, color: UIColor, tagNew: Int){
        for view in viewSuper.subviews {
            if let tag = view.tag {
                if tag != tagNew {
                    if(view.backgroundColor == color){
                        var tap = UITapGestureRecognizer(target:self, action:"tapChangeTwo:")
                        view.addGestureRecognizer(tap)
                    }
                }
            }
        }
    }
    
    func setAllFalse(){
        self.willRemove = false;
        self.willChange = false;
        self.willChangeTwo = false;
        self.removeButton.tintColor = UIColor.blackColor()
        self.ChangeButton.tintColor = UIColor.blackColor()
    }
    
    func findNextNumber() -> Int{
        return 0;
    }

    // MARK: Configurations UIButtonItem
    //clear all drawings
    @IBAction func clearTapped(){
        self.setAllFalse()
        var theDrawView : DrawView = drawView as! DrawView
        theDrawView.lines = []
        theDrawView.setNeedsDisplay()
    }
    
    @IBAction func undoTapped(){
        self.setAllFalse()
        
        var theDrawView : DrawView = drawView as! DrawView
        if (theDrawView.lines.count > 0) {
            while(theDrawView.lines.count != theDrawView.begin.last){
                theDrawView.lines.removeLast()
            }
            theDrawView.begin.removeLast()

        }
        theDrawView.setNeedsDisplay()
    }
    
    //change color
    @IBAction func colorTapped(button: UIBarButtonItem!){
        self.setAllFalse()
        
        var theDrawView : DrawView = drawView as! DrawView
        
        theDrawView.setterPaint(true)
        self.noEditButtonItem.tintColor = UIColor.blackColor()

        
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
    
    //change mode - without players or begin players
    @IBAction func changeMode(button: UIBarButtonItem!){
        self.compressPanel()

        if(self.isClear == true){
            //general - go to state 1
            self.bench.removeAll(keepCapacity: true)
            self.soccer.removeAll(keepCapacity: true)
            self.addBeginPlayers()
            self.addBegingBench()
            self.isClear = false
        }else{
            //empy - go to state 2
            self.soccer.removeAll(keepCapacity: true)
            self.removeAllPlayers()
            self.isClear = true
        }
    }
    
    //remove one players button
    @IBAction func removePlayer(button: UIBarButtonItem!){
        //avoids two selected buttons
        if(self.willChange == true || self.willChangeTwo == true){
            
            if(self.willChangeTwo == true){
                self.playerToMove.setBackGroungColor(self.colorFromPlayerToMove)
            }
            
            self.willChange = false
            self.willChangeTwo = false
            self.ChangeButton.tintColor = UIColor.blackColor()
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
    
    //change two players button
    @IBAction func ChangePlayer(button: UIBarButtonItem!){
        //avoids two selected buttons
        if(self.willRemove == true || self.willChangeTwo == true){
            
            if(self.willChangeTwo == true){
                self.playerToMove.setBackGroungColor(self.colorFromPlayerToMove)
                self.ChangeButton.tintColor = UIColor.blackColor()
                self.willChange = true
            }
            
            self.willRemove = false
            self.willChangeTwo = false
            self.removeButton.tintColor = UIColor.blackColor()
        }
        
            if(self.willChange == false){
                self.willChange = true
                self.setChange(self.mainView, button: button, tagNew: 101)
                self.setChange(self.view, button: button, tagNew: 102)
                self.setChange(self.view, button: button, tagNew: 103)
                
            }else{
                self.willChange = false
                button.tintColor = UIColor.blackColor()
            }
    }
    
    @IBAction func changeSoccer(button: UIBarButtonItem!){
        let image = UIImage(named: "square")
        let image2 = UIImage(named: "grass")

        if(button.image == image){
            //general - go to state 1
            button.image = image2
            self.typeImage.image = UIImage(named: "soccer")
        }else{
            //empy - go to state 2
            button.image = image
            self.typeImage.image = UIImage(named: "soccer2")
        }
    }

    @IBAction func addOnePlayerRedButton(sender: UIButton) {
        var DynamicView: PlayerView = PlayerView(color: self.redColor, text: 0, constX: 0.95, constY: 0.12, view:self.view , mainView: self.view)
        self.bench.append(DynamicView)
        
        
        var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
        touchDoublePlayer.numberOfTapsRequired  = 2
        DynamicView.addGestureRecognizer(touchDoublePlayer)
    }
    
    @IBAction func setEdit(sender: UIBarButtonItem) {
        var theDrawView : DrawView = drawView as! DrawView
        
        if(self.noEditButtonItem.tintColor != UIColor.grayColor()){
            theDrawView.setterPaint(false)
        
            self.noEditButtonItem.tintColor = UIColor.grayColor()
        }else{
            theDrawView.setterPaint(true)
            self.noEditButtonItem.tintColor = UIColor.blackColor()
        }
    
    }
    
    @IBAction func addOnePlayerButton(sender: UIButton) {
        var DynamicView: PlayerView = PlayerView(color: self.blueColor, text: 0, constX: 0.01, constY: 0.12, view:self.view , mainView: self.view)
        self.bench.append(DynamicView)
        
        var touchDoublePlayer = UITapGestureRecognizer(target:self, action:"doubleTap:")
        touchDoublePlayer.numberOfTapsRequired  = 2
        DynamicView.addGestureRecognizer(touchDoublePlayer)
    }
}
