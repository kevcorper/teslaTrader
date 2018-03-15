//
//  ViewController.swift
//  Tesla Trader
//
//  Created by Kevin Perkins on 3/14/18.
//  Copyright © 2018 Kevin Perkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let carsModel = Cars()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var model: UISegmentedControl!
    @IBOutlet weak var upgrades: UISegmentedControl!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var mileage: UISlider!
    @IBOutlet weak var condition: UISegmentedControl!
    @IBOutlet weak var evaluation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.setCustomSpacing(30, after: model)
        stackView.setCustomSpacing(30, after: upgrades)
        stackView.setCustomSpacing(30, after: mileage)
        stackView.setCustomSpacing(30, after: condition)
    }

    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileage.value) ?? "0"
        mileageLabel.text = "MILEAGE (\(formattedMileage) miles)"
        
        if let prediction = try? carsModel.prediction(
            model: Double(model.selectedSegmentIndex),
            premium: Double(upgrades.selectedSegmentIndex),
            mileage: Double(mileage.value),
            condition: Double(condition.selectedSegmentIndex)) {
            
            let clampedPrice = max(2000, prediction.price)
            
            formatter.numberStyle = .currency
            
            evaluation.text = formatter.string(for: clampedPrice)
        } else {
            evaluation.text = "Something went wrong!"
        }
    }
    
}

