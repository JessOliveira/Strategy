//
//  PopoverViewController.swift
//  Strategy
//
//  Created by Jessica Oliveira on 21/06/15.
//  Copyright (c) 2015 Jessica Oliveira. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var numbers: [String] = []
    var selectedNumber: String = ""
    var selectedPlayer:PlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 1...100 {
            self.numbers.append(String(i))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.numbers.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        self.selectedNumber = self.numbers[row]
        return self.numbers[row]
    }
    
    @IBAction func changeNumber(sender: UIButton) {
        self.selectedPlayer.setLabelChange(self.selectedNumber)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
