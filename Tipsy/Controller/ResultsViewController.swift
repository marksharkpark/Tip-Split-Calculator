//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Mark Park on 7/11/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var splitCost : String = "Error"
    var advice : String = "Splitting bill amongst x people, with x% tip."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = "$" + splitCost
        settingsLabel.text = advice

        // Do any additional setup after loading the view.
    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
