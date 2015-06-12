//
//  StrategyViewController.swift
//  Strategy
//
//  Created by Jessica Oliveira on 10/06/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

import UIKit

class StrategyViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var arrowOpponentImageView: UIImageView!
    @IBOutlet weak var arrowTeamImageView: UIImageView!
    
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var opponentView: UIView!
    
    @IBOutlet weak var teamWidth: NSLayoutConstraint!
    @IBOutlet weak var opponentWidth: NSLayoutConstraint!
    
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var ballImage: UIImageView!
    
    var isPanelExpanded = false;
    var isSelected = false;

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
        
        //create tap in icon image
        let tapIcon = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
            teamView.addGestureRecognizer(tapIcon)
        
        //create tap in icon image
        let tapIconOpponent = UITapGestureRecognizer(target: self, action: Selector("tapPanel:"))
        opponentView.addGestureRecognizer(tapIconOpponent)
        
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
    
    func pan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.view!)
        
        self.ballView.transform = CGAffineTransformTranslate(self.ballView.transform, translation.x, translation.y)
        recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }
    
    func panPlayer(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.view!)
        
//            self.playerTeamView.transform = CGAffineTransformTranslate(self.playerTeamView.transform, translation.x, translation.y)
            recognizer.setTranslation(CGPointZero, inView: self.view)
        
    }

}
