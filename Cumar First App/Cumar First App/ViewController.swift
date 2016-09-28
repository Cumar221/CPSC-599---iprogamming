
//
//  ViewController.swift
//  Cumar First App
//
//  Created by maya2016 on 2016-09-26.
//  Copyright © 2016 maya2016. All rights reserved.
//
/*
    Reference:
        Close keyboard with return & tap: http://stackoverflow.com/questions/24180954/how-to-hide-keyboard-in-swift-on-pressing-return-key
        Restrict any character, string and ect other than Integer for number textfiled: http://stackoverflow.com/questions/30973044/how-to-restrict-uitextfield-to-take-only-numbers-in-swift

*/

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numTxt: UITextField!
    @IBOutlet weak var doSomethingBtn: UIButton!
    @IBOutlet weak var switchTwo: UISwitch!
    @IBOutlet weak var switchOne: UISwitch!
    @IBOutlet weak var mySeg: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var slideLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numTxt.delegate = self
        nameTxt.delegate = self
        numTxt.keyboardType = .NumberPad
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Deals with alphanumeric keyboard and enables the return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // This deals with dismissing the keyboard if anywhere on the screen is tapped
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func doSomethingBtnPress(sender: UIButton) {
        alert("Everything's fine. You can breathe easy now and continue.", title: "Something was done")
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBAction func switchOneSync(sender: UISwitch) {
        if switchOne.on == true {
            switchTwo.on = true
        }
        else{
            switchTwo.on = false
        }
    }
    @IBAction func switchTwoSync(sender: UISwitch) {
        if switchTwo.on == true{
            switchOne.on = true
        }
        else{
            switchOne.on = false
        }
    }
    
    @IBAction func segChanged(sender: UISegmentedControl) {
        if doSomethingBtn.hidden == true{
            switchOne.hidden = true
            switchTwo.hidden = true
            doSomethingBtn.hidden = false
        }
        else{
            switchOne.hidden = false
            switchTwo.hidden = false
            doSomethingBtn.hidden = true
        }
    }
    
    @IBAction func btnSwtich(sender: UISegmentedControl) {
        switchOne.enabled = false
        switchTwo.hidden = true
        doSomethingBtn.hidden = false
    }
    
    @IBAction func switchDis(sender: UISegmentedControl) {
        switchOne.hidden = false
        switchTwo.hidden = false
        doSomethingBtn.hidden = true
    }
    
    @IBAction func sliderFunc(sender: UISlider) {
        let currentValue = Int(sender.value)
        slideLbl.text = "\(currentValue)"
    }
    

    // Restricts number textfieled to not accept anything other than integer
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == numTxt{
            let aSet = NSCharacterSet(charactersInString:"0123456789").invertedSet
            let compSepByCharInSet = string.componentsSeparatedByCharactersInSet(aSet)
            let numberFiltered = compSepByCharInSet.joinWithSeparator("")
            return string == numberFiltered
        }
        return true
    }

    @IBAction func numTxtEmpty(sender: AnyObject) {
        if numTxt.text == ""{
            numLbl.text = "The number field has been cleared."
        }
    }
    @IBAction func nameTxt(sender: AnyObject) {
        if nameTxt.text == "" {
            nameLbl.text = "The name field has been cleared."
        }
        else{
            nameLbl.text = "Hello \(String!(nameTxt.text))!"
        }
    }
    @IBAction func changeBtn(sender: AnyObject) {
        if numTxt.text == ""{
            numLbl.text = "The number field has been cleared."
        }
        else{
           numLbl.text = "The entered number is: \(String!(numTxt.text))"
        }
        numTxt.endEditing(true)
    }
}

