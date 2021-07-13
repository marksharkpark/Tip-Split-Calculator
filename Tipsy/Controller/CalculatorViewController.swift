//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var calcBrain = calculatorBrain()
    
    // Evaluating which tip was chosen. 
    @IBAction func tipChanged(_ sender: UIButton) {
      //  billTextField.endEditing(true)
        if sender.currentTitle == "20%"{
            percentCheck(check: "2")
            // button animation
            twentyPctButton.isSelected = true
            tenPctButton.isSelected = false
            zeroPctButton.isSelected = false
            
        }
        else if sender.currentTitle == "10%"{
            percentCheck(check: "1")
            // button animation
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            zeroPctButton.isSelected = false
        }
        else{
            percentCheck(check: "0")
            // button animation
            zeroPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tenPctButton.isSelected = false
        }
    }
    
    // Helper function in determining which percent to print. 
    func percentCheck(check : String){
        if check == "1"{
            calcBrain.percent = 1.1 // 1.0 + 0.1 to include cost with tip
            calcBrain.ten = true
            calcBrain.zero = false
            calcBrain.twenty = false
        }
        else if check == "2"{
            calcBrain.percent = 1.2 // 1.0 + 0.2 to include cost with tip
            calcBrain.twenty = true
            calcBrain.ten = false
            calcBrain.zero = false
        }
        else{
            calcBrain.percent = 0.0
            calcBrain.zero = true
            calcBrain.ten = false
            calcBrain.twenty = false
        }
    }
    
    // IBAction func:
    //      Incrementing stepper value and displaying. Also saving the value to include
    //      within resultviewcontroller
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        calcBrain.numPeople = sender.value
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    // IBAction func:
    //      Calculation of split cost among x people, then performing transition to
    //      resultviewcontroller
    @IBAction func calculatePressed(_ sender: UIButton) {
        let cost: Double = Double(billTextField.text!) ?? 0.0
        calcBrain.price = cost
        print(calcBrain.zero)
        if calcBrain.zero == false{
            calcBrain.output = (calcBrain.price / calcBrain.numPeople) * calcBrain.percent
        }
        else{
            calcBrain.output = (calcBrain.price / calcBrain.numPeople)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
                    
    }
    
    // Helper function to prepare for the next segueway with appropriate data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.splitCost = String(format: "%0.02f", calcBrain.output)
            
            
            if calcBrain.zero == true{
                destinationVC.advice = "Splitting bill amongst " + String(format: "%.0f", calcBrain.numPeople) + " people, with " + "0" + "% tip."
            }
            else if calcBrain.ten == true{
                destinationVC.advice = "Splitting bill amongst " + String(calcBrain.numPeople) + " people, with " + "10" + "% tip."
            }
            else{
                destinationVC.advice = "Splitting bill amongst " + String(calcBrain.numPeople) + " people, with " + "20" + "% tip."
            }
        }
    }
}

