//
//  ViewController.swift
//  Laureates
//
//  Created by Suresh Vutukuru on 18/12/20.
//  Copyright © 2020 Suresh Vutukuru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    fileprivate let pickerView = ToolbarPickerView()
    
    private var titles = [String]()
    private var laureates = [Laureate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.yearTextField.inputView = self.pickerView
        self.yearTextField.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        loadYearsDataInPicker()
        getLaureatesData()
        
        yearTextField.text = "1900"
        latitudeTextField.text = "40.8075355"
        longitudeTextField.text = "-73.9625727"
    }
    
    @IBAction func onTappingSubmit(_ sender: Any) {
        view.endEditing(true)
        validateInputs()
    }
    
    private func loadYearsDataInPicker() {
        for n in 1900...2020 {
            titles.append("\(n)")
        }
        self.pickerView.reloadAllComponents()
    }
    
    private func getLaureatesData() {
        if let path = Bundle.main.path(forResource: "nobel-prize-laureates", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let laureates = try JSONDecoder().decode([Laureate].self, from: data)
                self.laureates = laureates.sorted(by: {$0.year > $1.year}).reversed()
            } catch {}
        }
    }

    private func validateInputs() {
        if yearTextField.text!.isEmpty {
            showAlert(withMessage: "Please select a year")
            return
        }
        if latitudeTextField.text!.isEmpty || longitudeTextField.text!.isEmpty {
            showAlert(withMessage: "Invalid format of latitude and longitude values")
            return
        }
        if Double(latitudeTextField.text!) == nil || Double(longitudeTextField.text!) == nil {
            showAlert(withMessage: "Invalid format of latitude and longitude values")
            return
        }
        showResults()
    }
    
    private func showResults() {
        let results = self.laureates.filter({$0.location.lat == Double(latitudeTextField.text!) && $0.location.lng == Double(longitudeTextField.text!) && $0.year >= yearTextField.text!})
        if results.count == 0 {
            showAlert(withMessage: "No results found. Try again!")
            return
        }
        let resultsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultsTableViewController") as! ResultsTableViewController
        resultsView.laureates = Array(results.prefix(20))
        self.navigationController?.pushViewController(resultsView, animated: true)
    }
    
    private func showAlert(withMessage message: String) {
        let alertView = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
}

// MARK: - UITextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

// MARK: - PickerView DataSource & Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.titles.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.titles[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.yearTextField.text = self.titles[row]
    }
}

// MARK: - PickerView Toolbar Delegate
extension ViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        self.yearTextField.text = self.titles[row]
        self.yearTextField.resignFirstResponder()
    }

    func didTapCancel() {
        self.yearTextField.text = nil
        self.yearTextField.resignFirstResponder()
    }
}
