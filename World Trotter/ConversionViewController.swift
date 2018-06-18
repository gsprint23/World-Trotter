//
//  ConversionViewController.swift
//  World Trotter
//
//  Created by Gina Sprint on 6/18/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello from ConversionViewController.viewDidLoad()")
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let hour = getTime()
        if hour > 8 && hour < 12 {
            view.backgroundColor = UIColor.cyan
        }
        else if hour > 8 && hour < 20 {
            view.backgroundColor = UIColor.lightGray
        }
        else { // hour <= 8 || hour >=20
            view.backgroundColor = UIColor.darkGray
        }
    }
    
    func getTime() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        //let minutes = calendar.component(.minute, from: date)
        return hour
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
            // via a property observer on fahrenheitValue, updateCelsiusLable() will be called
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        print("here")
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // this method is called becaues the text field needs input (e.g. and answer to a q)
        // should the replacement string be accepted or rejected?
        print("Current text: \(textField.text)")
        print("Replacement text: \(string)")
        
        let characterSet = NSCharacterSet.letters
        let replacementTextHasLetters = string.rangeOfCharacter(from: characterSet)
        print(replacementTextHasLetters)
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            // already typed a . and is trying to type another .
            // don't let new . be added
            return false
        }
        else {
            // we don't have a dot already or the new text isnt a dot
            // okay to add a dot
            if replacementTextHasLetters != nil {
                // we have a letter, which we shouldn't add
                return false
            }
            return true
        }
    }
}
