//
//  ViewController.swift
//  homework2
//
//  Created by Yug Meghani on 3/8/21.
//

import UIKit

enum Label: String {
    case ten = "10 Percent ........ "
    case fifteen = "15 Percent ........ "
    case twenty = "20 Percent ........ "
}

class ViewController: UIViewController {
    @IBOutlet var billAmountTextField: UITextField!
    
    @IBOutlet var tenPercentLabel: UILabel!
    @IBOutlet var fifteenPercentLabel: UILabel!
    @IBOutlet var twentyPercentLabel: UILabel!
    
    var billAmount: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        do {
            try validateInput()
            self.billAmount = Float(billAmountTextField.text!)!
            updateUI()
        } catch {
            alert(view: self, title: "No Bill Amount Provided", message: "Please enter your bill amount")
        }
    }
    
    func updateUI() {
        tenPercentLabel.text = generateText(forLabel: .ten, withResult: billAmount! * 0.10)
        fifteenPercentLabel.text = generateText(forLabel: .fifteen, withResult: billAmount! * 0.15)
        twentyPercentLabel.text = generateText(forLabel: .twenty, withResult: billAmount! * 0.20)
    }
}

extension ViewController {
    func validateInput() throws {
        if let billAmount = billAmountTextField.text {
            if billAmount.isEmpty {
                throw "No value provided"
            } else {
                return
            }
        } else {
            throw "No value provided"
        }
    }
    
    func alert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    func generateText(forLabel label: Label, withResult result: Float) -> String {
        return "\(label.rawValue) $\(String(format: "%.2f", result))"
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}

extension ViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

